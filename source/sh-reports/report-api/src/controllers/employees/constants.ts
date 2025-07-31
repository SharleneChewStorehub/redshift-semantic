import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

export const dateField = {
    table: 'employee',
    field: 'createdtime',
};

export const optionalFilters: { [key: string]: Filter } = {
    id: {
        field: '_id',
        expression: '=',
    },
};

export const selectedFilters: ReqFilter[] = [];

export const optionalGroupBys: { [key: string]: GroupBy } = {};

export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    assignedStores: {
        field: {
            field: 'assignedstores',
        },
        kind: 'field',
    },
    accessallStores: {
        field: {
            field: 'accessallstores',
        },
        kind: 'field',
    },
};

export const selectedFields: { [key: string]: Field } = {};

export const sortableFields: { [key: string]: Field } = {
    createdtime: {
        field: 'createdtime',
    },
};

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {};

export const selectedAdvancedFields: { [key: string]: AdvancedField } = {};
