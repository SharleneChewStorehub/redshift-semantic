import express from 'express';

import context from '../../../src/controllers/context';
import transactionrecords from '../../../src/controllers/transactionrecords';
import { requestBody, dataRows, jsonData } from './case';
import * as errors from '../../../src/controllers/error';

describe('TEST:Controllers:TransactionRecords:index', () => {
    test('Func:transactionrecordsReport:Data', async () => {
        const contextSpy = jest.spyOn(context, 'getWarehouseResponse').mockReturnValue(
            new Promise(resolve => {
                resolve(dataRows);
            }),
        );
        jest.spyOn(errors, 'errorResponse').mockRejectedValue({} as never);

        const jsonMock = jest.fn();
        await transactionrecords.transactionrecords(
            { body: requestBody } as express.Request,
            {
                json: result => {
                    jsonMock(result);
                },
            } as express.Response,
        );

        expect(contextSpy).toHaveBeenCalled();
        expect(jsonMock).toHaveBeenCalledWith(jsonData);
    });

    test('Func:TransactionRecordsReport:WithoutData', async () => {
        const contextSpy = jest
            .spyOn(context, 'getWarehouseResponse')
            .mockReturnValue({} as Promise<any>);

        const jsonMock = jest.fn();
        await transactionrecords.transactionrecords(
            { body: requestBody } as express.Request,
            {
                json: result => {
                    jsonMock(result);
                },
            } as express.Response,
        );

        expect(contextSpy).toHaveBeenCalled();
        expect(jsonMock).toHaveBeenCalledTimes(0);
    });
});
