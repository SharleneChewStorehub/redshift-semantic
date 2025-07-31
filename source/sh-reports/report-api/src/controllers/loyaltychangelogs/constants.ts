import { AdvancedField, Field, Filter, GroupBy } from '../../interfaces/dataset';

export const dateField = {
    field: 'eventtime',
};

export const optionalFilters: { [key: string]: Filter } = {
    storeid: {
        table: 'customize__loyaltychangelogs_transactionrecds',
        field: 'storeid',
        expression: '=',
        value: '',
    },
};

export const optionalGroupBys: { [key: string]: GroupBy } = {
    hourly: {
        field: 'createdtime',
        type: 'HOUR',
        alias: 'date',
    },
    daily: {
        field: 'createdtime',
        type: 'DAY',
        alias: 'date',
    },
    weekly: {
        field: 'createdtime',
        type: 'WEEK',
        alias: 'date',
    },
    monthly: {
        field: 'createdtime',
        type: 'MONTH',
        alias: 'date',
    },
    quarter: {
        field: 'createdtime',
        type: 'QUARTER',
        alias: 'date',
    },
    yearly: {
        field: 'createdtime',
        type: 'YEAR',
        alias: 'date',
    },
};

export const selectedFields: { [key: string]: Field } = {
    count: {
        field: '*',
        functionName: 'COUNT',
    },
};

export const sortableFields: { [key: string]: Field } = {
    createdtime: {
        field: 'createdtime',
    },
};

// Measures for auto-complete
export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    totalClaim: {
        field: ['claim'],
        kind: 'advancedField',
    },
    totalRedeemed: {
        field: ['redeemed'],
        kind: 'advancedField',
    },
};

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {
    claim: {
        condition: {
            field: 'eventtype',
            expression: '=',
            value: 'earned',
            ifTrue: [
                {
                    field: 'amount',
                    symbol: '+',
                },
            ],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    redeemed: {
        condition: {
            field: 'eventtype',
            expression: 'in',
            value: ['expense', 'expense_freeze'],
            ifTrue: [
                {
                    field: 'amount',
                    symbol: '+',
                },
            ],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
};
