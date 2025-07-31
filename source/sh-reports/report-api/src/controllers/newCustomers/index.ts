import express from 'express';
import { errorResponse } from '../error';
import Customer from '../../../models/customer';
import mongoose from 'mongoose';

const controllers = {
    newCustomers: async (req: express.Request, res: express.Response) => {
        try {
            const { business, startTime, endTime, measures } = req.body;

            let query: any = {
                business,
                createdTime: {
                    $gte: new Date(startTime),
                    $lte: new Date(endTime),
                },
                isDeleted: { $ne: true },
            };

            if (measures) {
                delete query.createdTime;
            }

            Customer.find(query)
                .countDocuments()
                .exec((err: any, results: any) => {
                    if (err) {
                        console.error(err);
                    } else {
                        res.json(results);
                    }
                });
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
