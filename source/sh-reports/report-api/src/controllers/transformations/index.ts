import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import context from '../context';
import { parseFloatNumber, filterString } from '../utils';
import { isDate } from 'moment-timezone';
import { lastTransformationRun } from './jobs';

const schema = 'transformations';

const cleanupList = [
    'returns',
    'sales',
    'returnsCount',
    'tax',
    'subtotal',
    'tendered',
    'discount',
    'rounding',
    'serviceCharge',
    'cost',
    'customercount',
    'paymentSales',
    'paymentReturns',
    'preOrderDeposits',
    'salesItemsCount',
    'netSales',
];

const channelMap: any = {
    0: 'Offline',
    1: 'Ecommerce',
    98: 'Beep QR',
    99: 'Beep Delivery',
    10: 'GrabFood',
    11: 'ShopeeFood',
    12: 'FoodPanda',
    100: 'Lazada',
    101: 'Shopee',
    102: 'Zalora',
    103: 'WooCommerce',
    104: 'Shopify',
    105: 'TikTok Shop',
    110: 'Magento',
    111: 'Custom',
};

const orderTypeMap: any = {
    1: 'Dine in',
    2: 'Takeaway',
};

const getKeyByChannelName = (value: any) => {
    return Number(Object.keys(channelMap).find((k) => channelMap[k || 0] === value));
};

const getValueByChannelKey = (key: any) => {
    return String(channelMap[Number(key || 0)]);
};

const getKeyByOrderTypeName = (value: any) => {
    return Number(Object.keys(orderTypeMap).find((k) => orderTypeMap[k || 0] === value));
};

const cleanUpData = (measures: any[], data: any) => {
    cleanupList.forEach((item) => {
        if (!measures.includes(item)) {
            if (item === 'customercount' && measures.includes('totalCustomers')) {
                return;
            } else if (item === 'returnsCount' && measures.includes('returnsItemsCount')) {
                return;
            } else if (item === 'salesCount' && measures.includes('salesItemsCount')) {
                return;
            } else if (item === 'netSales' && measures.includes('itemNetSales')) {
                return;
            } else if (data[item] !== undefined) delete data[item];
            else if (data[item.toLowerCase()] !== undefined) delete data[item.toLowerCase()];
        }
    });
};

const filterEncode = (req: any) => {
    if (Array.isArray(req.body.filters) && req.body.filters.length > 0) {
        req.body.filters = req.body.filters.map((filter: any) => {
            const { value } = filter;
            if (Array.isArray(value)) {
                filter.value = value.map((val: any) => filterString(val));
            } else {
                filter.value = filterString(value);
            }
            return filter;
        });
    }

    return req;
};

const dataParserByMeasures = (measures: string[], data: any[]): any => {
    let result: any = { data: null };

    let totalSales = 0;
    let totalDiscount = 0;
    let count = 0;
    let totalCustomers = 0;

    data.forEach((row: any, index: number) => {
        Object.keys(data[index]).forEach((field: string) => {
            if (!isNaN(Number(data[index][field])) && !isDate(data[index][field])) {
                data[index][field] = parseFloat(data[index][field]);
            }
        });

        if (data[index].count) count += data[index].count;
        if (data[index].discount) totalDiscount += data[index].discount;
        if (data[index].customercount) totalCustomers += data[index].customercount;
        if (data[index].channel !== undefined)
            data[index].channel = getValueByChannelKey(data[index].channel);

        if (Array.isArray(measures) && measures.length > 0) {
            totalSales += data[index].sales;

            if (measures.includes('totalTransactions')) {
                data[index].totalTransactions =
                    parseFloat(data[index].count) - parseFloat(data[index].returnscount);
            }

            if (measures.includes('costAvg')) {
                data[index].costAvg = parseFloatNumber(data[index].cost / data[index].quantity);
            }

            if (measures.includes('discountAvg')) {
                data[index].discountAvg = parseFloatNumber(
                    data[index].discount / data[index].quantity,
                );
            }

            if (measures.includes('saleAvg')) {
                data[index].saleAvg = parseFloatNumber(data[index].sales / data[index].quantity);
            }

            if (measures.includes('taxableSales')) {
                data[index].taxablesales = parseFloatNumber(
                    data[index].sales - data[index].takeawayfee - data[index].returns,
                );
                data[index].sales = parseFloatNumber(
                    data[index].sales -
                        data[index].takeawayfee +
                        data[index].tax -
                        data[index].returns,
                );
            }

            if (measures.includes('discountPercentage')) {
                data[index].discountPercentage = data[index].discount / data[index].subtotal;
            }

            if (data[index].preorderdeposits && data[index].transactiontype === 'PreOrder') {
                data[index].preorderdeposits = 0;
            }

            if (measures.includes('paymentNetSales')) {
                data[index].paymentNetSales =
                    data[index].paymentsales +
                    data[index].preorderdeposits -
                    data[index].paymentreturns;
            }

            if (
                measures.includes('tendered') ||
                measures.includes('netSales') ||
                measures.includes('gp') ||
                measures.includes('avgNetSales') ||
                measures.includes('avgItemNetSales') ||
                measures.includes('itemNetSales') ||
                measures.includes('avgItemNetSalesByQuantity')
            ) {
                data[index].tendered = data[index].sales - data[index].returns;

                if (
                    measures.includes('netSales') ||
                    measures.includes('gp') ||
                    measures.includes('avgNetSales') ||
                    measures.includes('avgItemNetSales') ||
                    measures.includes('itemNetSales') ||
                    measures.includes('avgItemNetSalesByQuantity')
                ) {
                    if (
                        measures.includes('itemNetSales') ||
                        measures.includes('avgItemNetSales') ||
                        measures.includes('avgItemNetSalesByQuantity') ||
                        measures.includes('saleAvg')
                    ) {
                        data[index].netSales = data[index].tendered;
                        data[index].sales = data[index].sales + data[index].tax;
                    } else {
                        data[index].netSales =
                            data[index].tendered -
                            data[index].tax -
                            data[index].servicecharge -
                            data[index].rounding;
                    }

                    if (measures.includes('avgItemNetSales')) {
                        data[index].avgNetSales =
                            data[index].netSales > 0
                                ? parseFloatNumber(data[index].netSales / data[index].count)
                                : 0;
                    }

                    if (measures.includes('avgItemNetSalesByQuantity')) {
                        data[index].avgItemNetSalesByQuantity =
                            data[index].netSales > 0
                                ? parseFloatNumber(
                                      data[index].netSales / data[index].salesitemscount,
                                  )
                                : 0;
                    }

                    if (measures.includes('avgNetSales')) {
                        data[index].avgNetSales =
                            data[index].netSales > 0
                                ? parseFloatNumber(data[index].netSales / data[index].count)
                                : 0;
                    }

                    if (measures.includes('gp')) {
                        data[index].gp =
                            data[index].netSales > 0
                                ? parseFloatNumber(
                                      (data[index].netSales - data[index].cost) /
                                          data[index].netSales,
                                      4,
                                  )
                                : 0;
                    }

                    if (measures.includes('grossProfit')) {
                        data[index].grossProfit = data[index].netSales - data[index].cost;
                    }
                }
            }

            cleanUpData(measures, data[index]);
        }
    });

    result = { ...result, data, count };
    if (totalCustomers) result.totalCustomers = totalCustomers;
    if (totalSales) result.totalSales = totalSales;
    if (totalDiscount) result.totalDiscount = totalDiscount;
    if (totalSales && totalDiscount) {
        result.discountRate = parseFloatNumber(totalDiscount / totalSales);
    }

    return result;
};

const controllers = {
    getLastRun: (req: express.Request, res: express.Response) => {
        res.json({
            data: lastTransformationRun,
        });
        return;
    },
    salesReport: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            let table: string;
            switch (req.params.scope) {
                case 'transactionPromotion':
                    table = 'report_transaction_promotions';
                    break;
                case 'transactionRecordsItems':
                    table = 'report_transaction_items';
                    break;
                case 'transactionPayment':
                    table = 'report_transaction_payments';
                    break;
                case 'dashboardTransactions':
                    table = 'dashboard_transactions';
                    break;
                case 'dashboardTransactionItems':
                    table = 'dashboard_transaction_items';
                    break;
                case 'membershipSaleAov':
                    table = 'report_membership_sale_aov';
                    break;
                case 'stockTakeWastage':
                    table = 'report_stocktake_wastage';
                    break;
                default:
                    table = 'report_transactions';
            }

            if (Array.isArray(req.body.filters) && req.body.filters.length > 0) {
                req.body.filters.forEach((filter: any) => {
                    if (filter.name === 'channel') {
                        if (
                            (filter.expression === 'in' || filter.expression === 'not in') &&
                            Array.isArray(filter.value)
                        ) {
                            filter.value = filter.value.map((v: any) => getKeyByChannelName(v));
                        } else if (filter.expression === '=' || filter.expression === '<>') {
                            filter.value = getKeyByChannelName(filter.value);
                        }
                    }
                    if (filter.name === 'orderType') {
                        if (
                            (filter.expression === 'in' || filter.expression === 'not in') &&
                            Array.isArray(filter.value)
                        ) {
                            filter.value = filter.value.map((v: any) => getKeyByOrderTypeName(v));
                        } else if (filter.expression === '=' || filter.expression === '<>') {
                            filter.value = getKeyByOrderTypeName(filter.value);
                        }
                    }
                });
            }

            const resp = await context.getWarehouseResponse(
                'transformations',
                schema,
                table,
                filterEncode(req),
            );
            const data = dataParserByMeasures(req.body.measures, resp);

            res.json(data);
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
