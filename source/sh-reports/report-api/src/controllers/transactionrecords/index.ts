import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import context from '../context';
import { parseFloatNumber } from '../utils';

const schema = 'storehub_mongo';
const table = 'transactionrecords';

const stringFields = ['date', 'customerid'];

const controllers = {
    transactionrecords: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            const resp = await context.getWarehouseResponse(
                'transactionrecords',
                schema,
                table,
                req,
            );

            if (resp) {
                let count = 0;
                let total = 0;
                let netSalesTotal = 0;
                let categorySalesTotal = 0;
                let newUserCount = 0;
                let returnUserCount = 0;
                let newUserSales = 0;
                let returnUserSales = 0;
                let loyaltySales = 0;
                let nonLoyaltySales = 0;
                let loyaltySalesCount = 0;
                let nonLoyaltySalesCount = 0;
                let newLoyaltyCustomerCount = 0;
                let loyaltyCustomerCount = 0;
                let nonLoyaltyCustomerCount = 0;
                let customerCount = 0;

                resp.forEach((row: any, index: number) => {
                    Object.keys(resp[index]).forEach((field: string) => {
                        if (
                            !stringFields.includes(field) &&
                            !isNaN(parseFloat(resp[index][field]))
                        ) {
                            resp[index][field] = parseFloat(resp[index][field]);
                        }
                    });
                    if (typeof resp[index]['count'] !== 'undefined') {
                        count += resp[index]['count'];
                    }
                    if (row.sales !== null && row.sales !== undefined)
                        total += parseFloat(row.sales);
                    if (row.categorysales !== null && row.categorysales !== undefined)
                        categorySalesTotal += parseFloat(row.categorysales);
                    if (row.product_category === '') row.product_category = 'No Category';

                    if (Array.isArray(req.body.measures) && req.body.measures.length > 0) {
                        let tendered, netSales, gp, averageSale;
                        const tax = parseFloat(row.tax) || 0;
                        const serviceChange = parseFloat(row.servicecharge) || 0;
                        const rounding = parseFloat(row.rounding) || 0;
                        const cost = parseFloat(row.cost) || 0;
                        const sales = parseFloat(row.sales) || 0;
                        const returns = parseFloat(row.returns) || 0;
                        if (
                            req.body.measures.includes('tendered') ||
                            req.body.measures.includes('netSales') ||
                            req.body.measures.includes('gp') ||
                            req.body.measures.includes('averageSale')
                        ) {
                            tendered = sales - returns;
                        }

                        if (
                            (req.body.measures.includes('netSales') ||
                                req.body.measures.includes('gp') ||
                                req.body.measures.includes('averageSale')) &&
                            tendered !== undefined &&
                            tax !== undefined &&
                            serviceChange !== undefined &&
                            rounding !== undefined
                        ) {
                            netSales = tendered - tax - serviceChange - rounding;
                        }

                        if (req.body.measures.includes('gp') && netSales && cost !== undefined) {
                            gp = netSales > 0 ? parseFloatNumber((netSales - cost) / netSales) : 0;
                        }

                        if (
                            req.body.measures.includes('averageSale') &&
                            netSales !== undefined &&
                            row.count !== undefined
                        ) {
                            averageSale = parseFloatNumber(
                                row.count != 0 ? netSales / row.count : 0,
                            );
                        }

                        if (tendered !== undefined) resp[index].tendered = tendered;
                        if (netSales !== undefined) {
                            resp[index].netSales = netSales;
                            netSalesTotal += netSales;
                        }
                        if (gp !== undefined) resp[index].gp = gp;
                        if (averageSale !== undefined) resp[index].averageSale = averageSale;

                        if (req.body.measures.includes('Customer.newVsReturn')) {
                            if (resp[index].count <= 1) {
                                newUserCount += 1;
                                if (resp[index].netSales) newUserSales += resp[index].netSales;
                            } else {
                                returnUserCount += 1;
                                if (resp[index].netSales) returnUserSales += resp[index].netSales;
                            }
                        }

                        if (
                            req.body.measures.includes('salesComparsion') ||
                            req.body.measures.includes('loyaltySales')
                        ) {
                            loyaltySales += resp[index].loyaltysales;
                        }

                        if (
                            req.body.measures.includes('salesComparsion') ||
                            req.body.measures.includes('loyaltySalesCount')
                        ) {
                            loyaltySalesCount += resp[index].loyaltysalescount;
                        }

                        if (
                            req.body.measures.includes('salesComparsion') ||
                            req.body.measures.includes('nonLoyaltySales')
                        ) {
                            nonLoyaltySales += resp[index].nonloyaltysales;
                        }

                        if (
                            req.body.measures.includes('salesComparsion') ||
                            req.body.measures.includes('nonLoyaltySalesCount')
                        ) {
                            nonLoyaltySalesCount += resp[index].nonloyaltysalescount;
                        }

                        if (
                            req.body.measures.includes('customerCount') &&
                            Array.isArray(req.body.groupBys) &&
                            req.body.groupBys.includes('customerId')
                        ) {
                            if (resp[index].customerid !== '') {
                                if (resp[index].count === 1) newLoyaltyCustomerCount += 1;
                                loyaltyCustomerCount += 1;
                                customerCount += 1;
                            } else {
                                nonLoyaltyCustomerCount += resp[index].count;
                                customerCount += resp[index].count;
                            }
                        }
                    }
                });

                let result: any = {
                    count,
                    total,
                    average: parseFloatNumber(count ? total / count : 0),
                    data: resp,
                };
                if (categorySalesTotal) result = { ...result, categorySalesTotal };

                if (loyaltySales && loyaltySalesCount) {
                    result = {
                        ...result,
                        loyaltySales: parseFloatNumber(loyaltySales),
                        loyaltySalesCount: parseFloatNumber(loyaltySalesCount),
                        avgLoyaltySales: parseFloatNumber(loyaltySales / loyaltySalesCount),
                    };
                }
                if (nonLoyaltySales && nonLoyaltySalesCount) {
                    result = {
                        ...result,
                        nonLoyaltySales: parseFloatNumber(nonLoyaltySales),
                        nonLoyaltySalesCount: parseFloatNumber(nonLoyaltySalesCount),
                        avgNonLoyaltySales: parseFloatNumber(
                            nonLoyaltySales / nonLoyaltySalesCount,
                        ),
                    };
                }
                if (customerCount) {
                    result = {
                        ...result,
                        customerCount,
                        loyaltyCustomerCount,
                        newLoyaltyCustomerCount,
                        nonLoyaltyCustomerCount,
                    };
                }
                if (netSalesTotal)
                    result = {
                        ...result,
                        netSalesTotal: parseFloatNumber(netSalesTotal),
                        netSalesAvg: parseFloatNumber(netSalesTotal / count),
                    };

                if ((newUserCount && newUserSales) || (returnUserCount && returnUserSales)) {
                    res.json({
                        ...result,
                        newUserCount,
                        newUserSales,
                        returnUserCount,
                        returnUserSales,
                    });
                } else {
                    res.json(result);
                }
            } else {
                errorResponse(new Error('Interal Error.'), res);
            }
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
