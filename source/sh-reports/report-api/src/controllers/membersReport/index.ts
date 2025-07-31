import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import context from '../context';

const schema = 'transformations';

const controllers = {
    membersReport: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            let table: string;

            switch (req.params.scope) {
                case 'members':
                    table = 'report_members';
                    break;
                case 'membersTransactions':
                    table = 'report_members_transactions';
                    break;
                case 'membersTopN':
                    table = 'report_members_topn';
                    break;
                case 'membersRewards':
                case 'membersRewardsRedeemed':
                    table = 'report_members_rewards';
                    break;
                case 'membersNewCount':
                    table = 'report_members_new_count';
                    break;
                case 'membersRegistrationLocation':
                    table = 'report_members_registration_location';
                    break;
                case 'membersRegistrationMethod':
                    table = 'report_members_registration_method';
                    break;
                default:
                    table = 'report_members';
            }

            const data = await context.getWarehouseResponse('membersReport', schema, table, req);

            const result = {
                data,
            };

            res.json(result);
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
