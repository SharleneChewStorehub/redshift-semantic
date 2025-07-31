import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import context from '../context';
import { parseFloatNumber } from '../utils';

let schema: string;
if (process.env.NODE_ENV !== 'production') {
    schema = 'storehub_mongo';
} else {
    schema = 'storehub_mongo';
}

const table = 'storereviews';

const controllers = {
    feedbackReport: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            let result: any = { data: null };

            const data = await context.getWarehouseResponse('feedbackReport', schema, table, req);
            if (data) {
                data.forEach((row: any, index: number) => {
                    Object.keys(data[index]).forEach((field: string) => {
                        if (field !== 'date' && !isNaN(parseFloat(data[index][field]))) {
                            data[index][field] = parseFloat(data[index][field]);
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
