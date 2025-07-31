import { body } from 'express-validator/check';
import controllers from './index';

export function countCustomersRouter(router: any) {
    router.post('/countCustomers', [body('business').isString()], controllers.countCustomers);
}
