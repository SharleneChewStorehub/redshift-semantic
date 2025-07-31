import express from 'express';

import context from '../../../src/controllers/context';
import customers from '../../../src/controllers/customers';
import { requestBody, dataRows, jsonData } from './case';
import * as errors from '../../../src/controllers/error';

describe('TEST:Controllers:Customer:index', () => {
    test('Func:Customer:Data', async () => {
        const contextSpy = jest.spyOn(context, 'getWarehouseResponse').mockReturnValue(
            new Promise(resolve => {
                resolve(dataRows);
            }),
        );
        jest.spyOn(errors, 'errorResponse').mockRejectedValue({} as never);

        const jsonMock = jest.fn();
        await customers.customers(
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

    test('Func:Customer:WithoutData', async () => {
        const contextSpy = jest
            .spyOn(context, 'getWarehouseResponse')
            .mockReturnValue({} as Promise<any>);

        const jsonMock = jest.fn();
        await customers.customers(
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
