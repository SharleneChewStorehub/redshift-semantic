import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import redisClient from '../../redis';

const channelMap: any = {
    Offline: '',
    Ecommerce: 1,
    'Beep QR': 98,
    'Beep Delivery': 99,
    GrabFood: 10,
    ShopeeFood: 11,
    FoodPanda: 12,
    Custom: 111,
};

const orderTypeMap: any = {
    'Dine in': 1,
    Takeaway: 2,
};

function escapeRegexString(originalString: string) {
    if (typeof originalString == 'string') {
        const sre = new RegExp(
            '(\\' +
                ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\', '^'].join(
                    '|\\',
                ) +
                ')',
            'g',
        );
        const escapedSearchString = originalString.replace(sre, '\\$1');
        return escapedSearchString;
    } else {
        console.log('Invalid input when search product: %j', originalString);
        return originalString;
    }
}

function getBusinessTagsWithCache(business: string) {
    return new Promise((resolve) => {
        redisClient.smembers(`business:tags:${business}`, (err: any, tags: any) => {
            if (err) {
                console.log(err);
            } else {
                resolve(tags.sort());
            }
        });
    });
}

const filterStaticSuggestions: any = {
    status: [
        'shipped',
        'paid',
        'readyForDelivery',
        'readyForPickup',
        'paymentCancelled',
        'pendingPayment',
        'cancelled',
        'pendingVerification',
        'failed',
        'created',
        'pickedUp',
        'printed',
        'logisticsConfirmed',
        'accepted',
        'confirmed',
    ],
    channel: Object.keys(channelMap),
    orderType: Object.keys(orderTypeMap),
};

const filterRelatedModels: { [key: string]: Function } = {
    paymentMethod: (business: string): any => {
        return {
            model: require('../../../models/business'),
            conditions: {
                name: business,
                'paymentOptions.$.isDeleted': { $ne: true },
            },
            field: 'paymentOptions.name',
            manually: true,
        };
    },
    storeName: (business: string): any => {
        return {
            model: require('../../../models/business'),
            conditions: {
                name: business,
            },
            field: 'stores.name',
            manually: true,
        };
    },

    taxCodeName: (business: string): any => {
        return {
            model: require('../../../models/business'),
            conditions: {
                name: business,
            },
            field: 'taxCodes.name',
            manually: true,
        };
    },

    productTags: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/product'),
            conditions: {
                business: business,
            },
            field: 'tags',
        };
    },
    productTitle: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/product'),
            conditions: {
                business: business,
            },
            field: 'title',
        };
    },
    productCategory: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/product'),
            conditions: { business: business },
            field: 'category',
        };
    },
    parentProductTitle: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/product'),
            conditions: {
                business: business,
                parentProductId: {
                    $exists: false,
                },
            },
            field: 'title',
        };
    },
    skuNumber: (business: string): any => {
        return {
            model: require('../../../models/product'),
            conditions: {
                business: business,
            },
            field: 'skuNumber',
        };
    },
    customerPhone: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/customer'),
            conditions: { business: business },
            field: 'phone',
        };
    },
    customerEmail: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/customer'),
            conditions: { business: business },
            field: 'email',
        };
    },
    customerFirstName: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/customer'),
            conditions: { business: business },
            field: 'firstName',
        };
    },
    customerTags: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/customer'),
            conditions: { business: business },
            field: 'tags',
        };
    },
    customerLastName: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/customer'),
            conditions: { business: business },
            field: 'lastName',
        };
    },
    employeeEmail: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/employee'),
            conditions: { employerName: business },
            field: 'email',
        };
    },
    employeeFirstName: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/employee'),
            conditions: { employerName: business },
            field: 'firstName',
        };
    },
    employeeLastName: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/employee'),
            conditions: { employerName: business },
            field: 'lastName',
        };
    },
    supplierName: (business: string): any => {
        return {
            // eslint-disable-next-line
            model: require('../../../models/supplier'),
            conditions: { business },
            field: 'name',
        };
    },
};

const controllers = {
    suggestions: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            const { filter, search, business, platformEnabled } = req.body;

            if (Object.keys(filterStaticSuggestions).includes(filter)) {
                const suggestions: any[] = [];
                filterStaticSuggestions[filter].forEach((filter: string) => {
                    suggestions.push({ name: filter, _id: filter });
                });

                if (!platformEnabled.hadShopeeEnabled && filter !== 'orderType') {
                    let index = suggestions.findIndex((data) => data._id === 'ShopeeFood');
                    suggestions.splice(index, 1);
                }

                if (!platformEnabled.hadGrabEnabled && filter !== 'orderType') {
                    let index = suggestions.findIndex((data) => data._id === 'GrabFood');
                    suggestions.splice(index, 1);
                }

                if (!platformEnabled.hadFoodpandaEnabled && filter !== 'orderType') {
                    let index = suggestions.findIndex((data) => data._id === 'FoodPanda');
                    suggestions.splice(index, 1);
                }

                res.json({ suggestions });
                return;
            } else if (Object.keys(filterRelatedModels).includes(filter)) {
                const suggestions: any[] = [];
                const { model, conditions, field, manually } =
                    filterRelatedModels[filter](business);
                const regex = new RegExp(escapeRegexString(search), 'i');
                conditions[field] = { $regex: regex };
                const select: any = {};
                select[field] = 1;
                const fields = field.split('.');
                if (fields.length > 1) {
                    select[fields.slice(0, fields.length - 1).join('.') + '._id'] = 1;

                    select[fields.slice(0, fields.length - 1).join('.') + '.isDeleted'] = 1;
                } else if (fields.length === 1) {
                    select['_id'] = 1;
                    select['isDeleted'] = 1;
                }

                let data: any;

                if (filter === 'productTags') {
                    data = await getBusinessTagsWithCache(business);

                    if (data.length == 0) {
                        data = await model.find(conditions).select(select).limit(5000);
                    } else {
                        const regex = new RegExp(escapeRegexString(search), 'i');

                        data = [{ tags: data.filter((item: any) => regex.test(item)) }];

                        data.forEach((item: any) => {
                            item.toJSON = () => item;
                        });
                    }
                } else {
                    data = await model.find(conditions).select(select).limit(2000);
                }

                if (Array.isArray(data) && data.length > 0) {
                    data.forEach((record: any) => {
                        let suggestion: any = record.toJSON();
                        const keys = field.split('.');
                        keys.forEach((key: string) => {
                            if (Array.isArray(suggestion)) {
                                suggestion.forEach((subRecord: any) => {
                                    if (subRecord[key]) {
                                        if (subRecord['isDeleted']) {
                                            return false;
                                        }
                                        if (manually) {
                                            if (!regex.test(subRecord[key])) {
                                                return;
                                            }
                                        }
                                        if (filter === 'storeName') {
                                            suggestions.push({
                                                name: subRecord[key],
                                                _id: subRecord['_id'] || '',
                                            });
                                        } else if (
                                            !suggestions.find((s) => s.name === subRecord[key])
                                        ) {
                                            suggestions.push({
                                                name: subRecord[key],
                                                _id: subRecord['_id'] || '',
                                            });
                                        }
                                    }
                                });
                            } else {
                                if (suggestion[key]) {
                                    suggestion = Array.isArray(suggestion[key])
                                        ? suggestion[key]
                                        : { name: suggestion[key], _id: suggestion['_id'] || '' };
                                }
                            }
                        });

                        if (manually) {
                            if (!regex.test(suggestion)) {
                                return;
                            }
                        }

                        if (Array.isArray(suggestion)) {
                            suggestion.forEach((s: string) => {
                                if (
                                    typeof s !== 'object' &&
                                    !suggestions.find((sg) => sg.name === s)
                                ) {
                                    suggestions.push({
                                        name: s,
                                    });
                                }
                            });
                        } else if (
                            suggestion.name &&
                            !suggestions.find((sg) => sg.name === suggestion.name)
                        )
                            suggestions.push(suggestion);
                    });
                }

                res.json({ suggestions: suggestions.filter((s) => s.name !== '') });
                return;
            }

            res.json({ suggestions: [] });
            return;
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
