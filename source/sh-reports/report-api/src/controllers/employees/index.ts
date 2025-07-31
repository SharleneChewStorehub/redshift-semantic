import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import Warehouse from '../../warehouse/index';
import context from '../context';

const schema = 'storehub_mongo';
const table = 'employees';

const controllers = {
    employees: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            let storelist: any[] = [];
            let storeIds: string[] = [];
            let accessallStores: boolean = false;
            let data: any[] = [];

            const resp = await context.getWarehouseResponse('employees', schema, table, req);
            if (resp) {
                resp.forEach((row: any, index: number) => {
                    if (row['assignedstores']) {
                        resp[index]['assignedstores'] = row['assignedstores'].split(',');
                        storeIds = [...resp[index]['assignedstores'], ...storeIds];
                    }
                    if (row['accessallstores']) {
                        accessallStores = true;
                    }
                });
            }

            if (
                req.body.businessName &&
                Array.isArray(req.body.measures) &&
                req.body.measures.includes('assignedStores') &&
                req.body.measures.includes('accessallStores')
            ) {
                storelist = await Warehouse.getStoreList(schema, req.body.businessName);

                if (Array.isArray(storelist) && storelist.length > 0) {
                    storelist.forEach((item: any) => {
                        if (accessallStores || storeIds.includes(item._id)) {
                            data.push({
                                id: item._id,
                                name: item.name,
                                isdeleted: !!item.isdeleted,
                            });
                        }
                    });
                }
            } else {
                data = resp;
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
