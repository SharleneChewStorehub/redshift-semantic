import context from '../../src/controllers/context';
import * as utils from '../../src/controllers/utils';
import DatasetJsonBuilder from '../../src/builders/dataset';
import {
    optionalMeasures,
    optionalAdvancedFields,
} from '../../src/controllers/transactionrecords/constants';
import warehouse from '../../src/warehouse';
import express from 'express';

beforeEach(() => {
    jest.clearAllMocks();
});

const schema = 'storehub_mongo';
const table = 'transactionrecords';

describe('TEST:Controllers:Context', () => {
    test('Func:getAdvancedFieldsMap', () => {
        const result = context.getAdvancedFieldsMap(optionalMeasures, optionalAdvancedFields, {
            field: ['gp'],
            kind: 'advancedField',
        });
        expect(Object.keys(result).length).toBe(6);
    });

    test('Func:getWarehouseResponse', async () => {
        const isDateStringInvalidSpy = jest
            .spyOn(utils, 'isDateStringInvalid')
            .mockReturnValue(false);
        const parseJsonToSqlSpy = jest.spyOn(warehouse, 'parseJsonToSql').mockReturnValue({});
        const sendQuerySpy = jest.spyOn(warehouse, 'sendQuery').mockReturnValue({});
        const getTimezoneSpy = jest
            .spyOn(warehouse, 'getTimezone')
            .mockReturnValue('Asia/Kuala_Lumpur');

        const setFilterMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setFilter');
        const setDateRangeFilterMock = jest.spyOn(
            DatasetJsonBuilder.prototype,
            'setDateRangeFilter',
        );
        const setFieldMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setField');
        const setAdvancedFieldMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setAdvancedField');
        const setJoinMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setJoin');
        const setSortedMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setSorted');
        const setGroupByMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setGroupBy');
        const setPageMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setPage');
        const setSizeMock = jest.spyOn(DatasetJsonBuilder.prototype, 'setSize');
        const getJsonMock = jest.spyOn(DatasetJsonBuilder.prototype, 'getJson');

        const name = 'transactionrecords';
        const body = {
            business: 'xxx',
            startTime: '2019-01-01',
            endTime: '2019-01-01',
            groupBys: ['daily'],
            measures: ['gp', 'sales', 'ALL'],
            filters: [{ name: 'storeid', value: 'xxx', expression: '=' }],
            sorts: [{ name: 'date', order: 'desc' }, { name: 'createdtime', order: 'asc' }],
            size: 10,
            page: 1,
        };

        await context.getWarehouseResponse(name, schema, table, {
            body,
        } as express.Request);

        expect(setFilterMock).toHaveBeenCalled();
        expect(setFieldMock).toHaveBeenCalled();
        expect(setDateRangeFilterMock).toHaveBeenCalled();
        expect(setAdvancedFieldMock).toHaveBeenCalled();
        expect(setJoinMock).toHaveBeenCalled();
        expect(setSortedMock).toHaveBeenCalled();
        expect(setGroupByMock).toHaveBeenCalled();
        expect(setPageMock).toHaveBeenCalled();
        expect(setSizeMock).toHaveBeenCalled();
        expect(getJsonMock).toHaveBeenCalled();
        expect(isDateStringInvalidSpy).toHaveBeenCalled();
        expect(parseJsonToSqlSpy).toHaveBeenCalled();
        expect(getTimezoneSpy).toHaveBeenCalled();
        expect(sendQuerySpy).toHaveBeenCalled();
    });
});
