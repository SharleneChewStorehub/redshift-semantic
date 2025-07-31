export const requestBody = {
    business: 'megabite',
    startTime: '2019-05-07T00:00:00.000Z',
    endTime: '2019-08-07T15:59:59.999Z',
    measures: ['totalClaim', 'totalRedeemed'],
    filters: [
        {
            name: 'storeid',
            expression: '=',
            value: '55fbd6f1da2074c5278c939e',
        },
    ],
};

export const dataRows = [
    {
        count: 31519,
        claim: 189641.5,
        redeemed: -185619.76,
    },
];

export const jsonData = {
    count: 1,
    data: [
        {
            count: 31519,
            claim: 189641.5,
            redeemed: -185619.76,
        },
    ],
};
