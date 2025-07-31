import { body } from 'express-validator/check';
import controllers from './index';

export function loyaltychangelogsRouter(router: any) {
    router.post('/loyaltychangelogs', [body('business').isString()], controllers.loyaltychangelogs);
}
