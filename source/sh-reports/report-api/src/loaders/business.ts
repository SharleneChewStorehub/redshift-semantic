import Business, { BusinessSchema } from '../../models/business';
import { Types } from 'mongoose';

export default {
    getBusinessInfo: function (
        business: string,
        storeId: string,
        registerId: string,
    ): Promise<BusinessSchema> {
        return Business.aggregate([
            {
                $match: {
                    name: business,
                    'stores._id': new Types.ObjectId(storeId),
                    'cashRegisters._id': new Types.ObjectId(registerId),
                    'cashRegisters.storeId': new Types.ObjectId(storeId),
                },
            },
            {
                $project: {
                    enableCashback: 1,
                    isQROrderingEnabled: 1,
                    taxCodes: 1,
                    stores: {
                        $filter: {
                            input: '$stores',
                            as: 'store',
                            cond: { $eq: ['$$store._id', new Types.ObjectId(storeId)] },
                        },
                    },
                    cashRegisters: {
                        $filter: {
                            input: '$cashRegisters',
                            as: 'register',
                            cond: { $eq: ['$$register._id', new Types.ObjectId(registerId)] },
                        },
                    },
                },
            },
        ])
            .exec()
            .then((businesses: BusinessSchema[]) => businesses[0]);
    },
};
