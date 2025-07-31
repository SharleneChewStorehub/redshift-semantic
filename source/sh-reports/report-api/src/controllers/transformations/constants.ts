import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

// Date: GroupBy & OrderBy Field
export const dateField = {
    field: 'createdtime',
};

// Default field
export const selectedFields: { [key: string]: Field } = {
    count: {
        field: '*',
        functionName: 'COUNT',
    },
};

export const selectedFilters: ReqFilter[] = [
    {
        name: 'isCancelled',
        expression: 'is not',
        value: true,
        excludeTables: ['report_membership_sale_aov', 'report_stocktake_wastage'],
    },
    {
        name: 'transactionType',
        expression: '<>',
        value: 'PreOrder',
        excludeTables: [
            'report_transaction_payments',
            'report_membership_sale_aov',
            'report_stocktake_wastage',
        ],
    },
];

// Default advancedField
export const selectedAdvancedFields: { [key: string]: AdvancedField } = {};

// Filters bind with measure
export const bindFilters: {
    [key: string]: ReqFilter[];
} = {
    sales: [
        {
            name: 'status',
            expression: 'not in',
            value: ['pendingPayment', 'failed', 'created', 'paymentCancelled'],
        },
    ],
    paymentSales: [
        {
            name: 'status',
            expression: 'not in',
            value: ['pendingPayment', 'failed', 'created', 'paymentCancelled'],
        },
    ],
    promotionTotalTransactions: [
        {
            name: 'status',
            expression: 'not in',
            value: ['pendingPayment', 'failed', 'created', 'paymentCancelled'],
        },
    ],
    takeawayFee: [
        {
            name: 'itemType',
            expression: '<>',
            value: 'Discount',
        },
        {
            name: 'channel',
            expression: 'not in',
            value: [10, 11, 12],
        },
    ],
    salesItemsCount: [
        {
            name: 'productId',
            expression: '<>',
            value: '',
        },
    ],
    variationQuantity: [
        {
            name: 'productId',
            expression: '<>',
            value: '',
        },
    ],
};

// Sortable field
export const sortableFields: { [key: string]: Field } = {
    createdtime: {
        field: 'createdtime',
    },
    returnsItemsCount: {
        field: 'returnscount',
    },
    salesCount: {
        field: 'salescount',
    },
    salesItemsCount: {
        field: 'salesitemscount',
    },
    sales: {
        field: 'sales',
    },
    returns: {
        field: 'returns',
    },
    cost: {
        field: 'cost',
    },
    tendered: {
        field: 'tendered',
    },
    tax: {
        field: 'tax',
    },
    rounding: {
        field: 'rounding',
    },
    serviceCharge: {
        field: 'serviceCharge',
    },
    discount: {
        field: 'discount',
    },
    totalCustomers: {
        field: 'customercount',
    },
    preOrderDeposits: {
        field: 'preorderdeposits',
    },
    preOrderCount: {
        field: 'preordercount',
    },
    returnsCount: {
        field: 'returnscount',
    },
    paymentSales: {
        field: 'paymentsales',
    },
    paymentReturns: {
        field: 'paymentreturns',
    },
    paymentMethod: {
        field: 'paymentmethod',
    },
    promotionTotalTransactions: {
        field: 'promotiontotaltransactions',
    },
    promotionQuantity: {
        field: 'promotionquantity',
    },
    promotionDiscount: {
        field: 'promotiondiscount',
    },
    wastageCosts: {
        field: 'wastageCosts',
    },
    quantityWasted: {
        field: 'quantityWasted',
    },
    revenueLoss: {
        field: 'revenueLoss',
    },
    taxCodeName: {
        field: 'taxcodename',
    },
    taxRate: {
        field: 'taxrate',
    },
    taxableSales: {
        field: 'taxablesales',
    },
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
    orderType: {
        field: 'saleschannel',
        expression: '=',
        value: '',
    },
    isCancelled: {
        field: 'iscancelled',
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
    skuNumber: {
        field: 'skunumber',
        expression: '=',
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
    taxCodeName: {
        field: 'taxcodename',
        expression: '=',
        value: '',
    },
    productId: {
        field: 'productid',
        expression: '=',
        value: '',
    },
};

export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    returnsItemsCount: {
        field: ['returnsCount'],
        kind: 'advancedField',
    },
    totalTransactions: {
        field: ['returnsCount'],
        kind: 'advancedField',
    },
    totalSales: {
        field: ['sales'],
        kind: 'advancedField',
    },
    tendered: {
        field: ['sales', 'returns', 'returnsCount'],
        kind: 'advancedField',
    },
    itemNetSales: {
        field: ['tendered', 'tax'],
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
    grossProfit: {
        field: ['netSales', 'cost'],
        kind: 'advancedField',
    },
    avgNetSales: {
        field: ['netSales'],
        kind: 'advancedField',
    },
    avgItemNetSales: {
        field: ['itemNetSales'],
        kind: 'advancedField',
    },
    avgItemNetSalesByQuantity: {
        field: ['itemNetSales', 'salesItemsCount'],
        kind: 'advancedField',
    },
    totalCustomers: {
        field: {
            field: 'customerid',
            functionName: 'COUNTDISTINCT',
            alias: 'customercount',
        },
        kind: 'field',
    },
    costAvg: {
        field: ['cost', 'quantity'],
        kind: 'advancedField',
    },
    discountAvg: {
        field: ['discount', 'quantity'],
        kind: 'advancedField',
    },
    saleAvg: {
        field: ['sales', 'quantity'],
        kind: 'advancedField',
    },
    discountPercentage: {
        field: ['discount', 'subtotal'],
        kind: 'advancedField',
    },
    paymentNetSales: {
        field: ['paymentSales', 'preOrderDeposits', 'paymentReturns'],
        kind: 'advancedField',
    },
    membershipSaleAov: {
        field: {
            field: 'sale_aov',
            functionName: 'AVG',
            alias: 'saleAov',
        },
        kind: 'field',
    },
    wastageCosts: {
        field: {
            field: 'wastage_costs',
            functionName: 'SUM',
            alias: 'wastageCosts',
        },
        kind: 'field',
    },
    quantityWasted: {
        field: {
            field: 'quantity_wasted',
            functionName: 'SUM',
            alias: 'quantityWasted',
        },
        kind: 'field',
    },
    revenueLoss: {
        field: {
            field: 'revenue_loss',
            functionName: 'SUM',
            alias: 'revenueLoss',
        },
        kind: 'field',
    },
    taxableSales: {
        field: ['sales', 'takeawayfee'],
        kind: 'advancedField',
    },
};

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
    storeId: {
        field: 'storeid',
        type: 'TERM',
        alias: 'storeid',
    },
    storeName: {
        field: 'storename',
        type: 'TERM',
        alias: 'storeName',
    },
    customerName: {
        field: 'customer_name',
        type: 'TERM',
        alias: 'customer_name',
    },
    customerEmail: {
        field: 'customer_email',
        type: 'TERM',
        alias: 'customer_email',
    },
    customerPhone: {
        field: 'customer_phone',
        type: 'TERM',
        alias: 'customer_phone',
    },
    transactionType: {
        field: 'transactiontype',
        type: 'TERM',
        alias: 'transactiontype',
    },
    status: {
        field: 'status',
        type: 'TERM',
        alias: 'status',
    },
    paymentMethod: {
        field: 'payments_paymentmethod',
        type: 'TERM',
        alias: 'paymentMethod',
    },
    channel: {
        field: 'displaychannel',
        type: 'TERM',
        alias: 'channel',
    },
    productTitle: {
        field: 'product_title',
        type: 'TERM',
        alias: 'product_title',
    },
    productCategory: {
        field: 'product_category',
        type: 'TERM',
        alias: 'product_category',
    },
    parentProductTitle: {
        field: 'parentproduct_title',
        type: 'TERM',
        alias: 'parentproduct_title',
    },
    skuNumber: {
        field: 'skunumber',
        type: 'TERM',
        alias: 'skunumber',
    },
    employeeName: {
        field: 'employee_name',
        type: 'TERM',
        alias: 'employee_name',
    },
    employeeNumber: {
        field: 'employeenumber',
        type: 'TERM',
        alias: 'employeenumber',
    },
    employeeEmail: {
        field: 'employee_email',
        type: 'TERM',
        alias: 'employee_email',
    },
    variationValue: {
        table: 'variation_values',
        tableAlias: 'variation_values',
        field: 'value',
        type: 'TERM',
        alias: 'variation_value',
    },
    variationName: {
        table: 'variation_values',
        tableAlias: 'variation_values',
        field: 'name',
        type: 'TERM',
        alias: 'variation_name',
    },
    promotionName: {
        field: 'promotionname',
        type: 'TERM',
        alias: 'promotionname',
    },
    promotionCode: {
        field: 'promotioncode',
        type: 'TERM',
        alias: 'promotioncode',
    },
    promotionType: {
        field: 'discounttype',
        type: 'TERM',
        alias: 'promotiontype',
    },
    taxCodeName: {
        field: 'taxcodename',
        type: 'TERM',
        alias: 'taxcodename',
    },
    taxRate: {
        field: 'taxrate',
        type: 'TERM',
        alias: 'taxrate',
    },
};

// AdvancedFields for auto-complete
export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {
    subtotal: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'subtotal',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'subtotal',
                    symbol: '+',
                },
            ],
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
    paymentSales: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Sale',
            ifTrue: [
                {
                    field: 'payments_amount',
                    symbol: '+',
                },
            ],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    paymentReturns: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'payments_amount',
                    symbol: '+',
                },
            ],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    preOrderDeposits: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'PreOrder',
            ifTrue: [
                {
                    field: 'payments_amount',
                    symbol: '+',
                },
            ],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    preorderCount: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'PreOrder',
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    salesItemsCount: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'quantity',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'quantity',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    salesCount: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Sale',
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    returnsCount: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [{ value: 1 }],
            ifFalse: [{ value: 0 }],
        },
        functions: ['SUM'],
    },
    discount: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'discount',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'discount',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    shippingFee: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'shippingfee',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'shippingfee',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    quantity: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'quantity',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'quantity',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    variationQuantity: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    table: 'variation_values',
                    tableAlias: 'variation_values',
                    field: 'quantity',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    table: 'variation_values',
                    tableAlias: 'variation_values',
                    field: 'quantity',
                    symbol: '+',
                },
            ],
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
    pax: {
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
    promotionTotalTransactions: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: ['Sale'],
            ifTrue: [{ field: 'transactionid' }],
        },
        functions: ['DISTINCT', 'COUNT'],
    },
    promotionQuantity: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: ['Sale'],
            ifTrue: [
                {
                    field: 'promotion_quantity',
                    symbol: '+',
                },
            ],
            ifFalse: [
                {
                    value: 0,
                },
            ],
        },
        functions: ['SUM'],
    },
    promotionDiscount: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    value: 0,
                },
            ],
            ifFalse: [
                {
                    field: 'promotion_discount',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
    takeawayFee: {
        condition: {
            field: 'transactiontype',
            expression: '=',
            value: 'Return',
            ifTrue: [
                {
                    field: 'takeawayfee',
                    symbol: '-',
                },
            ],
            ifFalse: [
                {
                    field: 'takeawayfee',
                    symbol: '+',
                },
            ],
        },
        functions: ['SUM'],
    },
};
