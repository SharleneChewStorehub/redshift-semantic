// @flow

import Redshift from './redshift';
import { DatasetJson } from '../interfaces/dataset';

const config = {
    redshift: {
        host: process.env.AWS_REDSHIFT_HOST,
        port: process.env.AWS_REDSHIFT_PORT,
        user: process.env.AWS_REDSHIFT_USER,
        password: process.env.AWS_REDSHIFT_PASSWORD,
        database: process.env.AWS_REDSHIFT_DATABASE,
        max: parseInt(process.env.AWS_REDSHIFT_POOLSIZE),
    },
    postgresql: {
        host: process.env.AWS_POSTGRESQL_HOST,
        port: process.env.AWS_POSTGRESQL_PORT,
        user: process.env.AWS_POSTGRESQL_USER,
        password: process.env.AWS_POSTGRESQL_PASSWORD,
        database: process.env.AWS_POSTGRESQL_DATABASE,
        max: parseInt(process.env.AWS_POSTGRESQL_POOLSIZE),
    },
};

const commonRequestErrors = [
    'Out of Memory',
    'Connection terminated',
    'EADDRINUSE',
    'ECONNREFUSED',
    'ECONNRESET',
    'ENOTFOUND',
    'ETIMEDOUT',
    'EPIPE',
    '1023',
];

let client: any;
let pgClient: any;

const Warehouse = {
    init: async (warehouseName?: string) => {
        switch (warehouseName) {
            default:
                client = new Redshift(config.redshift);
                pgClient = new Redshift(config.postgresql);
                break;
        }
    },

    getClient: (dbSource: any) => {
        if (dbSource == 'postgresql') {
            return pgClient;
        } else {
            return client;
        }
    },

    parseJsonToSql: (json: DatasetJson, operationHours: number = 0) =>
        Redshift.parseJsonToSql(json, operationHours),

    sendQuery: (dbSource: any, ...args: any) => {
        let result;
        result = Warehouse.getClient(dbSource)
            .sendQuery(...args)
            .catch((err: Error) => {
                if (
                    dbSource == 'postgresql' &&
                    commonRequestErrors.find((cErr) => err && err.message.indexOf(cErr) !== -1)
                ) {
                    result = client.sendQuery(...args);
                    return result;
                }
            });
        return result;
    },

    getTimezone: (dbSource: any, ...args: any) =>
        Warehouse.getClient(dbSource).getTimezone(...args),

    getStoreList: (...args: any) => client.getStoreList(...args),
};

export default Warehouse;
