import { body } from 'express-validator/check';
import controllers from './index';

export function transformationsRouter(router: any) {
    router.post('/transformations/:scope', [body('business').isString()], controllers.salesReport);
    router.get('/transformations/lastSync', [], controllers.getLastRun);
}
