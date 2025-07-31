import { body } from 'express-validator/check';
import controllers from './index';

export function feedbackReportRouter(router: any) {
    router.post('/feedbackReport', [body('business').isString()], controllers.feedbackReport);
}
