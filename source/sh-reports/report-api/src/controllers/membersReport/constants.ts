import { AdvancedField, Field, Filter, GroupBy, ReqFilter } from '../../interfaces/dataset';

const createdtime = 'createdtime';

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
};

// Measures for auto-complete
export const optionalMeasures: {
    [key: string]: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' };
} = {
    totalMembers: {
        field: {
            field: 'totalmembers',
        },
        kind: 'field',
    },
    activeMembers: {
        field: {
            field: 'activemembers',
        },
        kind: 'field',
    },
    newMembersYesterday: {
        field: {
            field: 'newmembersyesterday',
        },
        kind: 'field',
    },
    newMembersPrevDay: {
        field: {
            field: 'newmembersprevday',
        },
        kind: 'field',
    },
    newMembersLast30Days: {
        field: {
            field: 'newmemberslast30days',
        },
        kind: 'field',
    },
    newMembersPrev30Days: {
        field: {
            field: 'newmembersprev30days',
        },
        kind: 'field',
    },
    floatingPoints: {
        field: {
            field: 'floatingpoints',
        },
        kind: 'field',
    },
    floatingCashback: {
        field: {
            field: 'floatingcashback',
        },
        kind: 'field',
    },
    totalMembersSpent: {
        field: {
            field: 'totalmembersspent',
        },
        kind: 'field',
    },
    totalMembersTransactions: {
        field: {
            field: 'totalmemberstransactions',
        },
        kind: 'field',
    },
    totalSpent: {
        field: {
            field: 'totalspent',
        },
        kind: 'field',
    },
    totalTransactions: {
        field: {
            field: 'totaltransactions',
        },
        kind: 'field',
    },
    customerName: {
        field: {
            field: 'customername',
        },
        kind: 'field',
    },
    lastPurchaseDate: {
        field: {
            field: 'lastpurchasedate',
        },
        kind: 'field',
    },
    totalPointEarned: {
        field: {
            field: 'totalpointearned',
        },
        kind: 'field',
    },
    totalCashbackEarned: {
        field: {
            field: 'totalcashbackearned',
        },
        kind: 'field',
    },
    rewardsRedeemed: {
        field: {
            field: 'totalrewardsredeemed',
            functionName: 'SUM',
            alias: 'totalrewardsredeemed',
        },
        kind: 'field',
    },
    totalRewardsRedeemed: {
        field: {
            field: 'totalrewardsredeemed',
        },
        kind: 'field',
    },
    newMemberRewardIssued: {
        field: {
            field: 'newmemberrewardissued',
        },
        kind: 'field',
    },
    newMemberRewardRedeemed: {
        field: {
            field: 'newmemberrewardredeemed',
        },
        kind: 'field',
    },
    createdTime: {
        field: {
            field: 'createdtime',
        },
        kind: 'field',
    },
    totalCashbackIssued: {
        field: {
            field: 'totalcashbackissued',
        },
        kind: 'field',
    },
    totalCashbackRedeemed: {
        field: {
            field: 'totalcashbackredeemed',
        },
        kind: 'field',
    },
    totalPointsIssued: {
        field: {
            field: 'totalpointsissued',
        },
        kind: 'field',
    },
    totalPointsRedeemed: {
        field: {
            field: 'totalpointsredeemed',
        },
        kind: 'field',
    },
    totalNewMembers: {
        field: {
            field: 'totalnewmembers',
            functionName: 'SUM',
            alias: 'totalnewmembers',
        },
        kind: 'field',
    },
    membersCountByLocation: {
        field: {
            field: 'memberscountbylocation',
            functionName: 'SUM',
            alias: 'memberscountbylocation',
        },
        kind: 'field',
    },
    membersCountBySource: {
        field: {
            field: 'memberscountbysource',
            functionName: 'SUM',
            alias: 'memberscountbysource',
        },
        kind: 'field',
    },
    totalCustomers: {
        field: {
            field: 'totalcustomers',
        },
        kind: 'field',
    },
};

export const optionalAdvancedFields: {
    [key: string]: AdvancedField;
} = {};

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
    membershipSource: {
        field: 'membershipsource',
        type: 'TERM',
        alias: 'membershipsource',
    },
};
