import { body } from 'express-validator/check';
import controllers from './index';

export function customersRouter(router: any) {
    router.post('/customers', [body('business').isString()], controllers.customers);
}
