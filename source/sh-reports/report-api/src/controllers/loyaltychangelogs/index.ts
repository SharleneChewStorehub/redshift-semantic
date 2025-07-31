import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import context from '../context';
import { parseFloatNumber } from '../utils';

const schema = 'storehub_mongo';
const table = 'loyaltychangelogs';

const controllers = {
    loyaltychangelogs: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            const data = await context.getWarehouseResponse(
                'loyaltychangelogs',
                schema,
                table,
                req,
            );
            if (data) {
                data.forEach((row: any, index: number) => {
                    Object.keys(data[index]).forEach((field: string) => {
                        if (field !== 'date' && !isNaN(parseFloat(data[index][field]))) {
                            data[index][field] = parseFloat(data[index][field]);
                        }
                    });
                });
            }

            const result = {
                count: data.length || 0,
                data,
            };

            res.json(result);
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
