import express from 'express';
import { errorResponse } from '../error';
import HourlyStoreSales from '../../../models/hourlyStoreSales';
import Business from '../../../models/business';
import mongoose from 'mongoose';

function getFormattedDate(date: any) {
    return (
        date.getUTCFullYear() * 1000000 +
        (date.getUTCMonth() + 1) * 10000 +
        date.getUTCDate() * 100 +
        date.getUTCHours()
    );
}

function getDateFormattedTime(inputDate: string) {
    let year = inputDate.substring(0, 4);
    let month = inputDate.substring(4, 6);
    let day = inputDate.substring(6, 8);
    let hour = inputDate.substring(8, 10);

    return year + '-' + month + '-' + day + ' ' + hour + ':00:00';
}

const controllers = {
    dashboard: async (req: express.Request, res: express.Response) => {
        try {
            const { business, measures, startTime, endTime, filters, groupBys } = req.body;

            const data: any = await Business.findOne().where('name', business).select('timezone');

            let timezone: string;
            if (data) {
                timezone = data['timezone'];
            } else {
                timezone = 'Asia/Kuala_Lumpur';
            }
            let _id: any = {};
            const $match: any = {
                business,
                date: {
                    $gte: getFormattedDate(new Date(startTime)),
                    $lte: getFormattedDate(new Date(endTime)),
                },
            };

            let storeIds: any[] = [];
            if (Array.isArray(filters) && filters.length > 0) {
                filters.forEach((filter: any) => {
                    if (filter.name === 'storeId') {
                        storeIds = filter.value;
                        $match.storeId = {
                            $in: storeIds.map((storeIds) => {
                                return typeof storeIds === 'string'
                                    ? mongoose.Types.ObjectId(storeIds)
                                    : storeIds;
                            }),
                        };
                    }
                });
            }

            if (Array.isArray(groupBys) && groupBys.length > 0) {
                groupBys.forEach((groupBy: string) => {
                    _id[groupBy] = '$' + groupBy;
                });
            }

            let $group: any = { _id };

            if (Array.isArray(measures) && measures.length > 0) {
                measures.forEach((measure: string) => {
                    $group[measure] = { $sum: `$${measure}` };
                });
            }

            let results = await HourlyStoreSales.aggregate([
                {
                    $match,
                },
                {
                    $group,
                },
            ]);

            if (Array.isArray(groupBys) && groupBys.length > 0) {
                if (groupBys.includes('date')) {
                    results = results.map((item: any) => {
                        const { _id, ...rest } = item;
                        return {
                            date: getDateFormattedTime(String(_id.date)),
                            ...rest,
                            timezone: timezone,
                        };
                    });
                }
            }

            res.json(results);
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
