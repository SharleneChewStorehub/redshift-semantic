import { body } from 'express-validator/check';
import controllers from './index';

export function engageReportRouter(router: any) {
    router.post('/engageReport/:scope', [body('business').isString()], controllers.engageReport);
}
