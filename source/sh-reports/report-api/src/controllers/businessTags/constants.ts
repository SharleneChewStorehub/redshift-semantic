import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

export const dateField = {
    field: 'createdtime',
};

export const selectedFilters: ReqFilter[] = [
    {
        name: 'business',
        expression: 'is not',
        value: null,
    },
];

export const bindFilters: {
    [key: string]: ReqFilter[];
} = {
    business: [
        {
            name: 'business',
            expression: 'is not',
            value: null,
        },
    ],
};

export const optionalFilters: { [key: string]: Filter } = {
    business: {
        field: 'business',
        expression: '=',
        value: '',
    },
};

export const optionalGroupBys: { [key: string]: GroupBy } = {};

export const selectedFields: { [key: string]: Field } = {};

export const sortableFields: { [key: string]: Field } = {};

// Measures for auto-complete
export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    tags: {
        field: {
            field: 'tags',
            alias: 'tags',
        },
        kind: 'field',
    },
    business: {
        field: {
            field: 'business',
            alias: 'business',
        },
        kind: 'field',
    },
};

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {};
