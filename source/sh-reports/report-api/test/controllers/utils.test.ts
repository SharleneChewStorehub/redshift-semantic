import { isDateStringInvalid } from '../../src/controllers/utils';

describe('TEST:Controllers:utils', () => {
    test('Func:isDateStringInvalid', () => {
        const validDate = '2019-01-01 10:10:10';
        const invalidDate = 'InvalidDate';

        expect(isDateStringInvalid(validDate)).toBe(false);
        expect(isDateStringInvalid(invalidDate)).toBe(true);
    });
});
