import {
    dateField,
    optionalFilters,
    optionalMeasures,
    optionalGroupBys,
    selectedFields,
    sortableFields,
    selectedAdvancedFields,
    optionalAdvancedFields,
} from '../../../src/controllers/customers/constants';

describe('TEST:Controllers:Customers:contants', () => {
    test('Constants:Exist', () => {
        expect(dateField).not.toBeNull();
        expect(optionalFilters).not.toBeNull();
        expect(optionalMeasures).not.toBeNull();
        expect(optionalGroupBys).not.toBeNull();
        expect(selectedFields).not.toBeNull();
        expect(sortableFields).not.toBeNull();
        expect(selectedAdvancedFields).not.toBeNull();
        expect(optionalAdvancedFields).not.toBeNull();
    });
});
