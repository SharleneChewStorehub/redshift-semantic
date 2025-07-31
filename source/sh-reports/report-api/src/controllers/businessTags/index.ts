import express from 'express';
import { validationResult } from 'express-validator/check';

import { errorResponse } from '../error';
import context from '../context';
import redisClient from '../../redis';

const schema = 'data_analysis';
const table = 'business_tags';

function existsBusinessTagsWithCache(business: any) {
    return new Promise((resolve, reject) => {
        redisClient.exists(`tags:${business}`, (err: any, count: any) => {
            if (err) {
                reject(`existsBusinessTagsWithCacheError: ${err}`);
            } else if (count === 0) {
                resolve(false);
            } else {
                resolve(true);
            }
        });
    });
}

function getBusinessTagsWithCache(business: any) {
    return new Promise((resolve, reject) => {
        redisClient.smembers(`tags:${business}`, (err: any, tags: any) => {
            if (err) {
                reject(err);
            } else {
                resolve(tags);
            }
        });
    });
}

function addBusinessTagsToCache(business: any, tags: any) {
    redisClient.sadd(business, tags, (err: any) => {
        if (err !== null) {
            console.error(`AddBusinessTagsToCacheError: ${err}`);
        } else {
            redisClient.expire(business, 168 * 3600, (err: any) => {
                if (err !== null) {
                    console.error(`SetBusinessTagsCacheExpireTimeError: ${err}`);
                }
            });
        }
    });
}

async function createTagsCache(business: string, req: express.Request) {
    try {
        const isTagsExist = await existsBusinessTagsWithCache(business);
        if (isTagsExist) {
            return;
        }

        req.body = {
            measures: ['business', 'tags'],
        };
        const data = await context.getWarehouseResponse('businessTags', schema, table, req);
        if (data) {
            data.forEach((row: any, index: number) => {
                Object.keys(data[index]).forEach(() => {
                    addBusinessTagsToCache(`tags:${data[index]['business']}`, data[index]['tags']);
                });
            });
        }
    } catch (err) {
        console.error(err);
    }
}

const controllers = {
    businessTags: async (req: express.Request, res: express.Response) => {
        try {
            validationResult(req).throw();

            let result: any = { data: null };
            let data: any;
            let { business } = req.body;

            data = await getBusinessTagsWithCache(business);

            result = { data };

            res.json(result);

            createTagsCache(business, req);
        } catch (err) {
            errorResponse(err, res);
        }
    },
};

export default controllers;
