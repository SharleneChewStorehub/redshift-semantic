import OnlineTransaction from '../../models/onlineTransaction';
import { Types } from 'mongoose';

export default {
    getShit: function(filter: {
        business: string;
        storeId: string;
        channel: number;
        startTime?: Date;
        endTime?: Date;
    }): Promise<
        Array<{
            _id: string;
            transactionCount: number;
            total: number;
            subtotal: number;
            discountCount: number;
            discount: number;
            serviceCharge: number;
            serviceChargeCount: number;
            tax: number;
            taxCount: number;
        }>
    > {
        const { business, storeId, channel, startTime, endTime } = filter;
        const match: { [key: string]: any } = {
            $or: [
                {
                    transactionType: 'Sale',
                    status: { $in: ['paid', 'confirmed'] },
                },
            ],
            business,
            storeId: new Types.ObjectId(storeId),
            channel,
        };
        if (startTime) {
            match.createdTime = { $gte: startTime };
        }
        if (endTime) {
            match.createdTime = match.createdTime || {};
            match.createdTime.$lt = endTime;
        }
        const startQueryTime: number = Date.now();
        return OnlineTransaction.aggregate([
            {
                $match: match,
            },
            {
                $project: {
                    receiptNumber: 1,
                    transactionType: 1,
                    total: 1,
                    subtotal: 1,
                    discount: 1,
                    tax: 1,
                    roundedAmount: 1,
                    serviceCharge: 1,
                    status: 1,
                },
            },
            {
                $group: {
                    _id: '$transactionType',
                    transactionCount: { $sum: 1 },
                    total: { $sum: '$total' },
                    subtotal: { $sum: '$subtotal' },
                    discountCount: { $sum: { $cond: [{ $gt: ['$discount', 0] }, 1, 0] } },
                    discount: { $sum: '$discount' },
                    serviceCharge: { $sum: '$serviceCharge' },
                    serviceChargeCount: { $sum: { $cond: [{ $gt: ['$serviceCharge', 0] }, 1, 0] } },
                    tax: { $sum: '$tax' },
                    taxCount: { $sum: { $cond: [{ $gt: ['$tax', 0] }, 1, 0] } },
                },
            },
        ])
            .exec()
            .then((result: any) => {
                console.log(
                    `beep_shift_report: ${new Date().toISOString()} business: ${
                        filter.business
                    }, storeId: ${filter.storeId}, totalTime: ${Date.now() - startQueryTime}ms`,
                );
                return result;
            });
    },
    getShitTax: function(filter: {
        business: string;
        storeId: string;
        channel: number;
        startTime: Date;
        endTime: Date;
    }): Promise<
        Array<{
            _id: { type: string; taxCode: string };
            amount: number;
        }>
    > {
        const { business, storeId, channel, startTime, endTime } = filter;
        const match: { [key: string]: any } = {
            $or: [
                {
                    transactionType: 'Sale',
                    status: { $in: ['paid', 'confirmed'] },
                },
            ],
            business,
            storeId: new Types.ObjectId(storeId),
            channel,
            createdTime: {
                $gte: startTime,
                $lt: endTime,
            },
        };
        const startQueryTime: number = Date.now();
        return OnlineTransaction.aggregate([
            {
                $match: match,
            },
            {
                $project: {
                    transactionType: 1,
                    'items.taxCode': 1,
                    'items.tax': 1,
                },
            },
            {
                $unwind: '$items',
            },
            {
                $group: {
                    _id: { type: '$transactionType', taxCode: '$items.taxCode' },
                    amount: { $sum: '$items.tax' },
                    count: { $sum: 1 },
                },
            },
        ])
            .exec()
            .then((result: any) => {
                console.log(
                    `beep_shift_report_tax_summary: ${new Date().toISOString()} business: ${
                        filter.business
                    }, storeId: ${filter.storeId}, totalTime: ${Date.now() - startQueryTime}ms`,
                );
                return result;
            });
    },
};
