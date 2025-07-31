import { body } from 'express-validator/check';
import controllers from './index';

export function newCustomersRouter(router: any) {
    router.post('/newCustomers', [body('filter').isString()], controllers.newCustomers);
}
