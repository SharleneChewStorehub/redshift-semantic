import { body } from 'express-validator/check';
import controllers from './index';

export function dashboardRouter(router: any) {
    router.post('/dashboard', [body('filter').isString()], controllers.dashboard);
}
