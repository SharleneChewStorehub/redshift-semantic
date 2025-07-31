import { parseJsonToSql } from '../../src/warehouse/redshift/sql';
import { DatasetJson } from '../../src/interfaces/dataset';

const schema = 'storehub_mongo';
const table = 'transactionrecords';

describe('TEST:warehouse:sql', () => {
    test('Func:parseJsonToSql', () => {
        const json: DatasetJson = {
            schema,
            table,
            timezone: '+8',
            dateRangers: [
                {
                    schema,
                    table,
                    field: 'createdtime',
                    startValue: '2018-01-01',
                    endValue: '2018-01-02',
                },
            ],
            filters: [
                {
                    schema,
                    table,
                    field: 'transactiontype',
                    expression: '=',
                    value: 'RETURN',
                },
                {
                    schema,
                    table,
                    field: 'total',
                    expression: 'is null',
                },
                {
                    schema,
                    table,
                    field: 'total',
                    expression: 'is not null',
                },
                {
                    schema,
                    table,
                    field: 'status',
                    expression: 'in',
                    value: ['paid', 'pendingPayment'],
                },
                {
                    schema,
                    table,
                    field: 'total',
                    expression: 'not in',
                    value: [10, 20],
                },
            ],
            fields: [
                {
                    field: '*',
                    functionName: 'COUNT',
                },
                {
                    schema,
                    table,
                    field: 'total',
                    functionName: 'AVG',
                },
                {
                    schema,
                    table,
                    field: 'total',
                    functionName: 'MIN',
                },
                {
                    schema,
                    table,
                    field: 'total',
                    functionName: 'MAX',
                },
                {
                    schema,
                    table,
                    field: 'total',
                    functionName: 'ROUND',
                },
                {
                    schema,
                    table,
                    field: 'total',
                    functionName: 'MEDIAN',
                },
                {
                    schema,
                    table,
                    field: 'createdtime',
                    functionName: 'DAY',
                },
                {
                    schema,
                    table: 'products',
                    field: 'title',
                },
                {
                    schema,
                    table: 'products',
                    field: 'total',
                    alias: 'product_total',
                    functionName: 'SUM',
                },
            ],
            joins: [
                {
                    schema,
                    table,
                    field: '_id',
                    joinSchema: schema,
                    joinTable: 'transactionrecords__items',
                    joinField: 'transactionrecords_foreignkey',
                },
                {
                    schema,
                    table: 'transactionrecords__items',
                    field: 'productid',
                    joinSchema: schema,
                    joinTable: 'products',
                    joinField: '_id',
                },
            ],
            leftJoins: [
                {
                    schema,
                    table,
                    field: 'business',
                    joinSchema: schema,
                    joinTable: 'businesses',
                    joinField: 'name',
                },
            ],
            groupBys: [
                {
                    schema,
                    table,
                    field: 'createdtime',
                    type: 'DAY',
                },
                {
                    schema,
                    table,
                    field: 'createdtime',
                    type: 'MONTH',
                },
                {
                    schema,
                    table,
                    field: 'createdtime',
                    type: 'HOUR',
                },
                {
                    schema,
                    table,
                    field: 'createdtime',
                    type: 'YEAR',
                },
                {
                    schema,
                    table: 'products',
                    field: 'title',
                    type: 'TERM',
                },
            ],
            sorteds: [
                {
                    schema,
                    table,
                    field: 'createdtime',
                    order: 'DESC',
                },
            ],
            page: 1,
            size: 100,
            advancedFields: [
                {
                    fields: [
                        { schema, table, field: 'total' },
                        { schema, table, field: 'subtotal' },
                        { value: 0 },
                        { value: 'str' },
                    ],
                    functions: ['SUM'],
                },
                {
                    condition: {
                        schema,
                        table,
                        field: 'status',
                        expression: 'in',
                        value: ['paid'],
                        ifTrue: [{ table, schema, field: 'total' }],
                        ifFalse: [{ value: 0 }],
                    },
                    functions: ['SUM'],
                },
                {
                    condition: {
                        schema,
                        table,
                        field: 'status',
                        expression: 'in',
                        value: ['paid'],
                        ifTrue: [{ table, schema, field: 'total' }],
                        ifFalse: [{ table, schema, field: 'total', symbol: '-' }],
                    },
                    functions: ['SUM'],
                },
                {
                    condition: {
                        schema,
                        table,
                        field: 'status',
                        expression: '=',
                        value: 'created',
                        ifTrue: [{ value: 'go' }],
                        ifFalse: [{ value: 'outgo' }],
                    },
                    functions: [],
                },
            ],
        };
        const query = parseJsonToSql(json, 0);
        expect(query).not.toBeNull();
    });
});
