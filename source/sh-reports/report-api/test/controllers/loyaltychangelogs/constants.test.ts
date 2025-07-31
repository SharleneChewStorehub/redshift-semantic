import {
    dateField,
    optionalFilters,
    optionalMeasures,
    optionalGroupBys,
    selectedFields,
    sortableFields,
    optionalAdvancedFields,
} from '../../../src/controllers/loyaltychangelogs/constants';

describe('TEST:Controllers:Loyaltychangelogs:contants', () => {
    test('Constants:Exist', () => {
        expect(dateField).not.toBeNull();
        expect(optionalFilters).not.toBeNull();
        expect(optionalMeasures).not.toBeNull();
        expect(optionalGroupBys).not.toBeNull();
        expect(selectedFields).not.toBeNull();
        expect(sortableFields).not.toBeNull();
        expect(optionalAdvancedFields).not.toBeNull();
    });
});
