import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

export const dateField = {
    field: 'createdtime',
};

export const selectedFilters: ReqFilter[] = [];

export const optionalFilters: { [key: string]: Filter } = {
    storeName: {
        field: 'storename',
        expression: '=',
        value: '',
    },
    storeId: {
        field: 'storeid',
        expression: '=',
        value: '',
    },
};

export const optionalGroupBys: { [key: string]: GroupBy } = {
    rating: {
        field: 'rating',
        type: 'TERM',
        alias: 'rating',
    },
};

export const selectedFields: { [key: string]: Field } = {};

export const sortableFields: { [key: string]: Field } = {};

// Measures for auto-complete
export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    totalPosts: {
        field: {
            field: 'rating',
            functionName: 'COUNT',
            alias: 'totalPosts',
        },
        kind: 'field',
    },
};

const createdtime = 'createdtime';

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {};
