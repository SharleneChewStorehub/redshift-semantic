import AwsRedshift from 'aws-redshift';
import { parseJsonToSql, getTimezoneSql, getStoreListSql } from './sql';

import { DatasetJson, RedshiftConfig } from '../../interfaces/dataset';
import { pushQuery, pushError } from '../../stats';

class Redshift {
    client: any;

    constructor(config: RedshiftConfig) {
        this.client = new AwsRedshift(config);
    }

    async sendQuery(query: string) {
        if (process.env.NODE_ENV === 'debug') console.log(query);

        const stateTimestamp = new Date().getTime();

        const result = await this.client.query(query, [{ raw: true }]).catch((err: Error) => {
            if (process.env.NODE_ENV === 'debug') console.log(err);
            pushError(query, err.message);
            throw err;
        });

        const queryTime = new Date().getTime() - stateTimestamp;

        pushQuery(queryTime);

        if (queryTime > 30 * 1000) {
            console.log(query, queryTime);
        }

        return result;
    }

    static parseJsonToSql(json: DatasetJson, operationHours: number = 0) {
        return parseJsonToSql(json, operationHours);
    }

    async getTimezone(schema: string, business: string) {
        const resp = await this.sendQuery(getTimezoneSql(schema, business)).catch((err: Error) => {
            return 'Asia/Kuala_Lumpur';
        });
        if (resp && resp.rows && resp.rows[0]) {
            return resp.rows[0].timezone;
        }
        return 'Asia/Kuala_Lumpur';
    }

    async getStoreList(schema: string, business: string) {
        const resp = await this.sendQuery(getStoreListSql(schema, business));

        return resp && resp.rows ? resp.rows : [];
    }
}

export default Redshift;
