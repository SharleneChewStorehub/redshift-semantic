import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

export const dateField = {
    field: 'createdtime',
};

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
    transactionType: {
        field: 'transactiontype',
        expression: '=',
        value: '',
    },
    status: {
        field: 'status',
        expression: '=',
        value: '',
    },
    channel: {
        field: 'displaychannel',
        expression: '=',
        value: '',
    },
    isdeleted: {
        field: 'isdeleted',
        expression: '=',
        value: '',
    },
    paymentMethod: {
        field: 'payments_paymentmethod',
        expression: '=',
        value: '',
    },
    productTitle: {
        field: 'product_title',
        expression: '=',
        value: '',
    },
    productCategory: {
        field: 'product_category',
        expression: '=',
        value: '',
    },
    parentProductTitle: {
        field: 'parentproduct_title',
        expression: '=',
        value: '',
    },
    productTags: {
        field: 'product_tags',
        expression: 'like',
        value: '',
    },
    customerId: {
        field: 'customerid',
        expression: '=',
        value: '',
    },
    customerName: {
        field: 'customer_name',
        expression: '=',
        value: '',
    },
    customerFirstName: {
        field: 'customer_firstname',
        expression: '=',
        value: '',
    },
    customerLastName: {
        field: 'customer_lastname',
        expression: '=',
        value: '',
    },
    customerEmail: {
        field: 'customer_email',
        expression: '=',
        value: '',
    },
    customerPhone: {
        field: 'customer_phone',
        expression: '=',
        value: '',
    },
    customerTags: {
        field: 'customer_tags',
        expression: 'like',
        value: '',
    },
    employeeNumber: {
        field: 'employeenumber',
        expression: '=',
        value: '',
    },
    employeeName: {
        field: 'employee_name',
        expression: '=',
        value: '',
    },
    employeeEmail: {
        field: 'employee_email',
        expression: '=',
        value: '',
    },
    employeeFirstName: {
        field: 'employee_firstname',
        expression: '=',
        value: '',
    },
    employeeLastName: {
        field: 'employee_lastname',
        expression: '=',
        value: '',
    },
    supplierIds: {
        field: 'supplierids',
        expression: 'like',
        value: '',
    },
    itemType: {
        field: 'itemtype',
        expression: '=',
        value: '',
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
    hourofday: {
        field: 'createdtime',
        type: 'HOUROFDAY',
        alias: 'date',
    },
    daily: {
        field: 'createdtime',
        type: 'DAY',
        alias: 'date',
    },
    dayofweek: {
        field: 'createdtime',
        type: 'DAYOFWEEK',
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
    employeeName: {
        field: 'employee_name',
        type: 'TERM',
        alias: 'employee_name',
    },
    business: {
        field: 'business',
        type: 'TERM',
        alias: 'business',
    },
};

export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {};

export const sortableFields: { [key: string]: Field } = {
    createdtime: {
        field: 'createdtime',
    },
};

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {
    newCustomers: {
        condition: {
            field: 'createdtime',
            expression: 'date_range',
            value: [],
            ifTrue: [{ field: 'customerid' }],
        },
        functions: ['DISTINCT', 'COUNT'],
    },
};
