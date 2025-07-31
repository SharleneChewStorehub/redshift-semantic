import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

// Date: GroupBY & OrderBy Field
export const dateField = {
    field: 'createdtime',
};

// Filters for auto-complete
export const optionalFilters: { [key: string]: Filter } = {
    storeid: {
        field: 'storeid',
        expression: '=',
        value: '',
    },
    transactiontype: {
        field: 'transactiontype',
        expression: '=',
        value: '',
    },
    registerid: {
        field: 'registerid',
        expression: '=',
        value: '',
    },
    customerid: {
        field: 'customerid',
        expression: '=',
        value: '',
    },
    iscancelled: {
        field: 'iscancelled',
        expression: '=',
        value: '',
    },
    channel: {
        field: 'channel',
        expression: '=',
        value: '',
    },
    status: {
        field: 'status',
        expression: 'in',
        value: '',
    },
    employeenumber: {
        field: 'employeenumber',
        expression: '=',
        value: '',
    },
    itemtype: {
        table: 'transactionrecords__items',
        field: 'itemtype',
        expression: '<>',
        value: '',
    },
};

// Measures for auto-complete
export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    tendered: {
        field: ['sales', 'returns'],
        kind: 'advancedField',
    },
    netSales: {
        field: ['tendered', 'tax', 'rounding', 'serviceCharge'],
        kind: 'advancedField',
    },
    gp: {
        field: ['netSales', 'cost'],
        kind: 'advancedField',
    },
    averageSale: {
        field: ['netSales'],
        kind: 'advancedField',
    },
    salesComparsion: {
        field: ['loyaltySales', 'nonLoyaltySales', 'loyaltySalesCount', 'nonLoyaltySalesCount'],
        kind: 'advancedField',
    },
};

// Filters bind with measure
export const bindFilters: {
    [key: string]: ReqFilter[];
} = {
    sales: [
        {
            name: 'iscancelled',
            expression: 'is not',
            value: true,
        },
        {
            name: 'status',
            expression: 'not in',
            value: ['pendingPayment', 'failed', 'created', 'paymentCancelled'],
        },
    ],
    loyaltySales: [
        {
            name: 'iscancelled',
            expression: 'is not',
            value: true,
        },
        {
            name: 'status',
            expression: 'not in',
            value: ['pendingPayment', 'failed', 'created', 'paymentCancelled'],
        },
    ],
};

// Groups for auto-complete
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
    storeId: {
        field: 'storeid',
        type: 'TERM',
        alias: 'storeId',
    },
    customerId: {
        field: 'customerid',
        type: 'TERM',
        alias: 'customerId',
    },
    transactionType: {
        field: 'transactiontype',
        type: 'TERM',
        alias: 'transactionType',
    },
    channel: {
        field: 'channel',
        type: 'TERM',
        alias: 'channel',
    },
    'Product.Category': {
        table: 'products_category',
        tableAlias: 'category_product_table',
        field: 'category',
        type: 'TERM',
        alias: 'product_category',
    },
    'Product.Title': {
        table: 'transactionrecords__items',
        field: 'title',
        type: 'TERM',
        alias: 'product_title',
    },
};

// Default field
export const selectedFields: { [key: string]: Field } = {
    count: {
        field: '*',
        functionName: 'COUNT',
    },
};

// Sortable field
export const sortableFields: { [key: string]: Field } = {
    createdtime: {
        field: 'createdtime',
    },
};

// Default advancedField
export const selectedAdvancedFields: { [key: string]: AdvancedField } = {};

// AdvancedFields for auto-complete
export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {
    quantity: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    table: 'transactionrecords__items',
                    field: 'quantity',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    table: 'transactionrecords__items',
                    field: 'quantity',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    loyaltySalesCount: {
        condition: {
            field: 'customerid',
            expression: '=',
            value: '',
            ifTrue: [{ value: 0 }],
            ifFalse: [{ value: 1 }],
        },
        functions: ['SUM'],
    },
    nonLoyaltySalesCount: {
        condition: {
            field: 'customerid',
            expression: '=',
            value: '',
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    loyaltySales: {
        condition: {
            field: 'customerid',
            expression: '=',
            value: '',
            ifTrue: [{ value: 0 }],
            ifFalse: [
                {
                    field: 'total',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    nonLoyaltySales: {
        condition: {
            field: 'customerid',
            expression: '=',
            value: '',
            ifTrue: [
                {
                    field: 'total',
                    symbol: '+',
                },
            ],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    sales: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [{ value: 0 }],
            ifFalse: [
                {
                    field: 'total',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    categorySales: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    table: 'transactionrecords__items',
                    field: 'total',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    table: 'transactionrecords__items',
                    field: 'total',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    returns: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'total',
                    symbol: '+',
                },
            ],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    rounding: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'roundedamount',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'roundedamount',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    tax: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'tax',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'tax',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    serviceCharge: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'servicecharge',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'servicecharge',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    cost: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'cost',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'cost',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    totalPax: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [{ value: 0 }],
            ifFalse: [
                {
                    field: 'pax',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
};
