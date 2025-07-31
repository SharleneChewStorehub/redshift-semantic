import express from 'express';

import context from '../../../src/controllers/context';
import loyaltychangelogs from '../../../src/controllers/loyaltychangelogs';
import { requestBody, dataRows, jsonData } from './case';
import * as errors from '../../../src/controllers/error';

describe('TEST:Controllers:Loyaltychangelogs:index', () => {
    test('Func:Loyaltychangelogs:Data', async () => {
        const contextSpy = jest.spyOn(context, 'getWarehouseResponse').mockReturnValue(
            new Promise(resolve => {
                resolve(dataRows);
            }),
        );
        jest.spyOn(errors, 'errorResponse').mockRejectedValue({} as never);

        const jsonMock = jest.fn();
        await loyaltychangelogs.loyaltychangelogs(
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

    test('Func:Loyaltychangelogs:WithoutData', async () => {
        const contextSpy = jest
            .spyOn(context, 'getWarehouseResponse')
            .mockReturnValue({} as Promise<any>);

        const jsonMock = jest.fn();
        await loyaltychangelogs.loyaltychangelogs(
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
