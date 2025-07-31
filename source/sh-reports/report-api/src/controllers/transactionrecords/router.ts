import { body } from 'express-validator/check';
import controllers from './index';

export function transactionrecordsRouter(router: any) {
    router.post(
        '/transactionrecords',
        [body('business').isString()],
        controllers.transactionrecords,
    );
}
