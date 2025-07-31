import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

const createdtime = 'createdtime';

export const dateField = {
    field: 'createdtime',
};

export const selectedFilters: ReqFilter[] = [];

// Default advancedField
export const selectedAdvancedFields: { [key: string]: AdvancedField } = {};

export const optionalFilters: { [key: string]: Filter } = {
    globalCampaignInformationId: {
        field: 'globalcampaigninformationid',
        expression: '=',
        value: '',
    },
    isCancelled: {
        field: 'iscancelled',
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
    txnCreatedtime: {
        field: 'txncreatedtime',
        expression: 'date_range',
        value: [`"${createdtime}"`, `("${createdtime}" + INTERVAL '21 days')`],
    },
    customerPhone: {
        field: 'customerphone',
        expression: '=',
        value: '',
    },
    total: {
        field: 'total',
        expression: 'is not null',
    },
};

export const optionalGroupBys: { [key: string]: GroupBy } = {
    globalCampaignInformationId: {
        field: 'globalcampaigninformationid',
        type: 'TERM',
        alias: 'globalcampaigninformationid',
    },
    weekly: {
        field: 'createdtime',
        type: 'WEEK',
        alias: 'date',
    },
};

export const selectedFields: { [key: string]: Field } = {};

export const sortableFields: { [key: string]: Field } = {
    smsCreatedtime: {
        field: 'createdtime',
    },
    txnCreatedtime: {
        field: 'txncreatedtime',
    },
};

// Measures for auto-complete
export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    totalCustomers: {
        field: {
            field: 'customerphone',
            functionName: 'COUNTDISTINCT',
            alias: 'totalCustomers',
        },
        kind: 'field',
    },
    totalFeedbackCustomers: {
        field: {
            field: 'customerphone',
            functionName: 'COUNTDISTINCT',
            alias: 'totalFeedbackCustomers',
        },
        kind: 'field',
    },
    totalSmsSent: {
        field: {
            field: 'messageunits',
            functionName: 'SUM',
            alias: 'totalSmsSent',
        },
        kind: 'field',
    },
    totalSmsCosts: {
        field: {
            field: 'messageamount',
            functionName: 'SUM',
            alias: 'totalSmsCosts',
        },
        kind: 'field',
    },
    totalFreeSmsCosts: {
        field: {
            field: 'freemessageamount',
            functionName: 'SUM',
            alias: 'totalFreeSmsCosts',
        },
        kind: 'field',
    },
    totalReturnCustomers: {
        field: {
            field: 'txncustomerid',
            functionName: 'COUNTDISTINCT',
            alias: 'totalReturnCustomers',
        },
        kind: 'field',
    },
    customerPhone: {
        field: {
            field: 'customerphone',
            alias: 'customerphone',
        },
        kind: 'field',
    },
    txnCreatedtime: {
        field: {
            field: 'txncreatedtime',
            alias: 'txncreatedtime',
        },
        kind: 'field',
    },
    total: {
        field: {
            field: 'total',
            alias: 'total',
        },
        kind: 'field',
    },
    smsCreatedtime: {
        field: {
            field: 'createdtime',
            alias: 'smsCreatedtime',
        },
        kind: 'field',
    },
    totalPhone: {
        field: {
            field: 'customerphone',
            functionName: 'COUNT',
            alias: 'totalPhone',
        },
        kind: 'field',
    },
    channel: {
        field: {
            field: 'channel',
            alias: 'channel',
        },
        kind: 'field',
    },
    receiptNumber: {
        field: {
            field: 'receiptnumber',
            alias: 'receiptnumber',
        },
        kind: 'field',
    },
    transactionId: {
        field: {
            field: 'transactionid',
            alias: 'transactionid',
        },
        kind: 'field',
    },
    cashbackRedeemed: {
        field: {
            field: 'cashbackredeemed',
            alias: 'cashbackredeemed',
        },
        kind: 'field',
    },
};

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {
    repurchaseTotal: {
        condition: {
            field: 'txncreatedtime',
            expression: 'date_range',
            value: [`"${createdtime}"`, `("${createdtime}" + INTERVAL '21 days')`],
            ifTrue: [{ field: 'total' }],
        },
        functions: ['SUM'],
        alias: 'repurchaseTotal',
    },
};
