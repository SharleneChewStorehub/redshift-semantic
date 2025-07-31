import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import context from '../context';
import { parseFloatNumber } from '../utils';

const schema = 'transformations';

const controllers = {
    engageReport: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            let result: any = { data: null };

            let table: string;

            if (process.env.NODE_ENV !== 'production') {
                switch (req.params.scope) {
                    case 'smsCosts':
                        table = 'report_sms_costs';
                        break;
                    case 'repurchaseTotal':
                        table = 'report_engage';
                        break;
                    case 'feedbackSms':
                        table = 'report_feedback_sms';
                        break;
                    default:
                        table = 'report_engage';
                }
            } else {
                switch (req.params.scope) {
                    case 'smsCosts':
                        table = 'report_sms_costs';
                        break;
                    case 'repurchaseTotal':
                        table = 'report_engage';
                        break;
                    case 'feedbackSms':
                        table = 'report_feedback_sms';
                        break;
                    default:
                        table = 'report_engage';
                }
            }

            const campaignInfoIds = process.env.CAMPAIGN_ID.split(',');

            if (
                req.body.groupBys?.length === 0 &&
                table != 'report_feedback_sms' &&
                req.body.sorts?.length === 0
            ) {
                req.body.filters = [
                    {
                        name: 'globalCampaignInformationId',
                        expression: 'in',
                        value: campaignInfoIds,
                    },
                ];
            }

            const txnCreatedtimeFilter = req.body.filters.find(
                (filter: { name: string }) => filter.name === 'txnCreatedtime',
            );

            if (txnCreatedtimeFilter) {
                txnCreatedtimeFilter.value = [
                    'createdtime',
                    `("createdtime" + INTERVAL '21 days')`,
                ];
            }

            let data = await context.getWarehouseResponse('engageReport', schema, table, req);

            if (data) {
                data.forEach((row: any, index: number) => {
                    Object.keys(data[index]).forEach((field: string) => {
                        if (
                            field.includes('totalsmscosts') &&
                            field.includes('totalFeedbackCustomers')
                        ) {
                            data[index].totalsmscosts =
                                data[index].totalsmscosts > 0
                                    ? parseFloatNumber(data[index].totalsmscosts * 0.1, 2)
                                    : 0;
                        }

                        if (
                            field !== 'date' &&
                            field !== 'globalcampaigninformationid' &&
                            field !== 'receiptnumber' &&
                            field !== 'transactionid' &&
                            !isNaN(parseFloat(data[index][field]))
                        ) {
                            data[index][field] = parseFloat(data[index][field]);
                        }

                        if (field.includes('smscreatedtime')) {
                            data[index].smscreatedtime = new Date(
                                new Date(data[index].smscreatedtime).getTime() + 8 * 60 * 60 * 1000,
                            ).toISOString();
                        }

                        if (field.includes('txncreatedtime')) {
                            data[index].txncreatedtime = new Date(
                                new Date(data[index].txncreatedtime).getTime() + 8 * 60 * 60 * 1000,
                            ).toISOString();
                        }
                    });
                });
            }

            result = { ...result, data };

            res.json(result);
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
