import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

export const dateField = {
    table: 'customers',
    field: 'createdtime',
};

export const optionalFilters: { [key: string]: Filter } = {
    storeid: {
        table: 'customize__customer_transactionrecords',
        field: 'storeid',
        expression: '=',
    },
    isdeleted: {
        field: 'isdeleted',
        expression: 'is not',
    },
    totaltransactions: {
        field: 'totaltransactions',
        expression: 'is not null',
    },
};

export const selectedFilters: ReqFilter[] = [
    {
        name: 'isdeleted',
        expression: 'is not',
        value: true,
    },
];

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

export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    totalFloat: {
        field: {
            field: 'storecreditsbalance',
            functionName: 'SUM',
            alias: 'totalfloat',
        },
        kind: 'field',
    },
    totalSpend: {
        field: {
            field: 'totalspent',
            functionName: 'SUM',
            alias: 'totalspend',
        },
        kind: 'field',
    },
    spendAverage: {
        field: {
            field: 'totalspent',
            functionName: 'AVG',
            alias: 'spendaverage',
        },
        kind: 'field',
    },
    totalTransactions: {
        field: [
            'transaction_count_1',
            'transaction_count_2',
            'transaction_count_3',
            'transaction_count_4',
            'transaction_count_5',
            'transaction_count_6',
            'transaction_count_7',
            'transaction_count_8',
            'transaction_count_9',
            'transaction_count_10',
        ],
        kind: 'advancedField',
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

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {
    transaction_count_1: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 1,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_2: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 2,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_3: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 3,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_4: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 4,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_5: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 5,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_6: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 6,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_7: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 7,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_8: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 8,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_9: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 9,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    transaction_count_10: {
        condition: {
            field: 'totaltransactions',
            expression: '>=',
            value: 10,
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
};

export const selectedAdvancedFields: { [key: string]: AdvancedField } = {};
