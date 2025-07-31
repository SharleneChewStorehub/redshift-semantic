import { body } from 'express-validator/check';
import controllers from './index';

export function membersReportRouter(router: any) {
    router.post('/membership/:scope', [body('business').isString()], controllers.membersReport);
}
