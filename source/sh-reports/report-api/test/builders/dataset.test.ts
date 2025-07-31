import DatasetJsonBuilder from '../../src/builders/dataset';
import { Sorted, GroupBy, FieldFuncs } from '../../src/interfaces/dataset';

const schema = 'storehub_mongo_xxx';
const table = 'transactionrecords';

describe('TEST:Builders:Dataset', () => {
    test('Func:newBuilder', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        const json = builder.getJson();

        expect(json.schema).toBe(schema);
        expect(json.table).toBe(table);
    });

    test('Func:setPage&Size', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        builder.setPage(1);
        builder.setSize(10);
        const json = builder.getJson();

        expect(json.page).toBe(1);
        expect(json.size).toBe(10);
    });

    test('Func:setJoin', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        builder.setJoin('products_category');
        const json = builder.getJson();

        expect(json.joins.length).toBe(2);
    });

    test('Func:setField', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        builder.setField({
            schema,
            table: 'products_category',
            field: 'title',
        });
        const json = builder.getJson();

        expect(json.joins.length).toBe(2);
        expect(json.fields.length).toBe(1);
    });

    test('Func:setGroupBy', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        const groupBy: GroupBy = {
            schema,
            table: 'products_category',
            field: 'title',
            type: 'TERM',
            alias: 'product_title',
        };
        builder.setGroupBy(groupBy);
        const json = builder.getJson();

        expect(json.joins.length).toBe(2);
        expect(json.groupBys).toMatchObject([groupBy]);
        expect(json.fields).toMatchObject([
            {
                schema: groupBy.schema,
                table: groupBy.table,
                field: groupBy.field,
                functionName: groupBy.type !== 'TERM' ? (groupBy.type as FieldFuncs) : undefined,
                alias: groupBy.alias,
            },
        ]);
    });

    test('Func:setSorted', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        const sort: Sorted = {
            schema: 'xxx',
            field: 'xxx',
            table: 'xxx',
            order: 'DESC',
        };
        builder.setSorted(sort);
        const json = builder.getJson();

        expect(json.sorteds).toMatchObject([sort]);
    });

    test('Func:setFilter', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        builder.setFilter({
            table: 'products_category',
            field: 'title',
            expression: '=',
        });
        const json = builder.getJson();

        expect(json.filters.length).toBe(1);
        expect(json.joins.length).toBe(2);
    });

    test('Func:setAdvancedField', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        builder.setAdvancedField({
            fields: [
                {
                    table: 'products_category',
                    field: 'total',
                    symbol: '+',
                },
                {
                    field: 'total',
                    symbol: '+',
                },
            ],
            functions: ['SUM'],
        });
        builder.setAdvancedField({
            functions: ['SUM'],
            condition: {
                table: 'transactionrecords__items',
                field: 'total',
                expression: 'in',
                value: [20, 10],
                ifTrue: [
                    {
                        table: 'products',
                        field: 'total',
                        symbol: '+',
                    },
                ],
                ifFalse: [
                    {
                        table: 'products',
                        field: 'total',
                        symbol: '-',
                    },
                ],
            },
        });
        const json = builder.getJson();

        expect(json.joins.length).toBe(2);
        expect(json.advancedFields.length).toBe(2);
    });

    test('Func:setDateRangeFilter', () => {
        const builder = new DatasetJsonBuilder(schema, table);
        builder.setDateRangeFilter(
            { table: 'products_category', field: 'createdtime' },
            '2019-01-01',
            '2019-10-10',
        );
        const json = builder.getJson();

        expect(json.joins.length).toBe(2);
        expect(json.dateRangers).toMatchObject([
            {
                table: 'products_category',
                field: 'createdtime',
                startValue: '2019-01-01',
                endValue: '2019-10-10',
            },
        ]);
    });
});
