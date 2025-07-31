export const requestBody = {
    business: 'megabite',
    startTime: '2019-05-07T16:00:00.000Z',
    endTime: '2019-08-07T15:59:59.999Z',
    filters: [
        {
            name: 'storeid',
            expression: '=',
            value: '55fbd6f1da2074c5278c939e',
        },
    ],
    measures: ['totalSpend', 'spendAverage'],
};

export const dataRows = [
    {
        count: 2874,
        totalspend: 4200545,
        spendaverage: 1770.89,
    },
];

export const jsonData = {
    count: 1,
    data: [
        {
            count: 2874,
            totalspend: 4200545,
            spendaverage: 1770.89,
        },
    ],
};
