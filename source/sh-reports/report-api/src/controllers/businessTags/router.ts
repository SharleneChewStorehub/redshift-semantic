import { body } from 'express-validator/check';
import controllers from './index';

export function businessTagsRouter(router: any) {
    router.post('/business/tags', [body('business').isString()], controllers.businessTags);
}
