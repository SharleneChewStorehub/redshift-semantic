import express from 'express';
import { body, validationResult } from 'express-validator/check';
import { Types } from 'mongoose';
import { toFixedNumberProperties } from '../utils';

import { errorResponse } from '../error';

import loader from '../../loaders';
import business from '../../loaders/business';

export function beepRouter(router: any) {
    router.post(
        '/beepReport',
        [
            body('business').isString(),
            body('storeId').isString(),
            body('registerId').isString(),
            body('startTime').isString(),
            body('endTime').isString(),
        ],
        controllers.beepReport,
    );
}

function getTaxSummary(taxCodes: any, taxList: any) {
    const taxCodeMap: {
        [key: string]: { _id: string; name: string; rate: number; isDeleted: boolean };
    } = {};
    for (const taxCode of taxCodes) {
        // @ts-ignore
        taxCodeMap[taxCode._id] = taxCode;
    }
    const taxMap: {
        [key: string]: { amount: number; taxName: string; taxRate: number };
    } = {};
    for (const tax of taxList) {
        taxMap[tax._id.taxCode] = taxMap[tax._id.taxCode] || {
            taxName: (taxCodeMap[tax._id.taxCode] && taxCodeMap[tax._id.taxCode].name) || '',
            taxRate: (taxCodeMap[tax._id.taxCode] && taxCodeMap[tax._id.taxCode].rate) || 0,
            amount: 0,
        };
        if (tax._id.type === 'Sale') {
            taxMap[tax._id.taxCode].amount += tax.amount;
        } else if (tax._id.type === 'Return') {
            taxMap[tax._id.taxCode].amount += tax.amount;
        }
    }
    for (const taxId in taxMap) {
        if (taxMap[taxId].amount === 0) {
            taxMap[taxId] = undefined;
        }
    }
    return taxMap;
}

const controllers = {
    beepReport: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();
            req.body.startTime = new Date(req.body.startTime);
            req.body.endTime = new Date(req.body.endTime);
            if (
                !Types.ObjectId.isValid(req.body.storeId) ||
                !Types.ObjectId.isValid(req.body.registerId)
            ) {
                return errorResponse(new Error(`Invalidate storeId or registerId`), res);
            }
            const business = await loader.business.getBusinessInfo(
                req.body.business,
                req.body.storeId,
                req.body.registerId,
            );
            if (!business || !business.cashRegisters[0] || !business.stores[0]) {
                return errorResponse(new Error(`Business, Store or Register does not exist.`), res);
            }
            if (!business.isQROrderingEnabled) {
                return res.json();
            }
            const store = business.stores[0];
            if (store.qrRegisters && store.qrRegisters.length) {
                // filter [''] scenarios
                const qrRegisters = store.qrRegisters.filter((register: any) => register);
                if (!qrRegisters.includes(req.body.registerId)) {
                    return res.json();
                }
            }
            const filter = {
                business: req.body.business,
                storeId: req.body.storeId,
                channel: 3,
                startTime: req.body.startTime,
                endTime: req.body.endTime,
            };
            const [taxList, resultList] = await Promise.all([
                loader.transaction.getShitTax(filter),
                loader.transaction.getShit(filter),
            ]);
            if (!resultList.length) {
                return res.json();
            }
            // separate return and sales
            // no roundedAmount for online transactions
            const result = {
                transactionCount: 0,
                grossSales: 0,
                return: 0,
                returnCount: 0,
                discount: 0,
                discountedCount: 0,
                netSales: 0,
                serviceCharge: 0,
                tax: 0,
                totalTendered: 0,
                discountSummary: {
                    sales: {
                        amount: 0,
                        count: 0,
                    },
                    returns: {
                        amount: 0,
                        count: 0,
                    },
                },
                paymentSummary: {
                    sales: {
                        amount: 0,
                        count: 0,
                    },
                    returns: {
                        amount: 0,
                        count: 0,
                    },
                },
                serviceChargeSummary: {
                    sales: {
                        amount: 0,
                        count: 0,
                    },
                    returns: {
                        amount: 0,
                        count: 0,
                    },
                },
                taxSummary: getTaxSummary(business.taxCodes, taxList),
                // Reserved field for beep
                loyaltyDiscounts: {
                    sales: {
                        amount: 0,
                        count: 0,
                    },
                    cancel: {
                        amount: 0,
                        count: 0,
                    },
                },
            };
            for (const item of resultList) {
                result.discountedCount += item.discountCount;
                result.transactionCount += item.transactionCount;
                if (item._id === 'Sale') {
                    item._id = undefined;
                    result.grossSales += item.subtotal;
                    result.discount += item.discount;
                    result.serviceCharge += item.serviceCharge;
                    result.serviceChargeSummary.sales.amount += item.serviceCharge;
                    result.serviceChargeSummary.sales.count += item.serviceChargeCount;
                    result.totalTendered += item.total;
                    result.paymentSummary.sales.amount += item.total;
                    result.paymentSummary.sales.count += item.transactionCount;
                    result.tax += item.tax;
                    result.discountSummary.sales.amount += item.discount;
                    result.discountSummary.sales.count += item.discountCount;
                } else if (item._id === 'Return') {
                    item._id = undefined;
                    result.grossSales -= item.subtotal;
                    result.return += item.subtotal;
                    result.discount -= item.discount;
                    result.serviceCharge -= item.serviceCharge;
                    result.serviceChargeSummary.returns.amount += item.serviceCharge;
                    result.serviceChargeSummary.returns.count += item.serviceChargeCount;
                    result.totalTendered -= item.total;
                    result.paymentSummary.returns.amount += item.total;
                    result.paymentSummary.returns.count += item.transactionCount;
                    result.tax -= item.tax;
                    result.returnCount += item.transactionCount;
                    result.discountSummary.returns.amount += item.discount;
                    result.discountSummary.returns.count += item.discountCount;
                }
            }
            result.netSales = result.grossSales - result.return - result.discount;
            return res.json(toFixedNumberProperties(result));
        } catch (err) {
            return errorResponse(err, res);
        }
    },
};
