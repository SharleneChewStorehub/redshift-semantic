import { body } from 'express-validator/check';
import controllers from './index';

export function employeesRouter(router: any) {
    router.post('/employees', [], controllers.employees);
}
