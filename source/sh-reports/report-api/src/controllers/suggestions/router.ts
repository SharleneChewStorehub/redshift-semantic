import { body } from 'express-validator/check';
import controllers from './index';

export function suggestionsRouter(router: any) {
    router.post('/suggestions', [body('filter').isString()], controllers.suggestions);
}
