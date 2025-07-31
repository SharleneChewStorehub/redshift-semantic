import { Filter, DateRangeFilter, Join } from './interfaces/dataset';

export const relations: {
    [key: string]: {
        [key: string]: Join[];
    };
} = {
    report_transaction_items: {
        variation_values: [
            {
                table: 'report_transaction_items',
                field: '_id',
                joinTable: 'report_transaction_variationvalues',
                joinField: 'transactionrecords__items_foreignkey',
                joinAlias: 'variation_values',
            },
        ],
    },
    transactionrecords: {
        transactionrecords__items: [
            {
                table: 'transactionrecords',
                field: '_id',
                joinTable: 'transactionrecords__items',
                joinField: 'transactionrecords_foreignkey',
            },
        ],
        products_category: [
            {
                table: 'transactionrecords',
                field: '_id',
                joinTable: 'transactionrecords__items',
                joinField: 'transactionrecords_foreignkey',
            },
            {
                table: 'transactionrecords__items',
                field: 'productid',
                joinTable: 'customize__product_category_transactionrecords',
                joinField: 'original_id',
                joinAlias: 'category_product_table',
            },
        ],
    },
    customers: {
        customize__customer_transactionrecords: [
            {
                table: 'customers',
                field: 'customerid',
                joinTable: 'customize__customer_transactionrecords',
                joinField: 'customerid',
                joinAlias: 'customize__customer_transactionrecords',
            },
        ],
    },
    loyaltychangelogs: {
        customize__loyaltychangelogs_transactionrecds: [
            {
                table: 'loyaltychangelogs',
                field: 'receiptnumber',
                joinTable: 'customize__loyaltychangelogs_transactionrecds',
                joinField: 'receiptnumber',
                joinAlias: 'customize__loyaltychangelogs_transactionrecds',
            },
        ],
        transactionrecords: [
            {
                table: 'loyaltychangelogs',
                field: 'receiptnumber',
                joinTable: 'transactionrecords',
                joinField: 'receiptnumber',
            },
        ],
    },
};

export const customizeRelations: { [key: string]: Function } = {
    customize__loyaltychangelogs_transactionrecds: (
        filters: Filter[],
        dateRangers: DateRangeFilter[],
    ) => {
        const businessFilter = filters.find((filter: Filter) => {
            return filter.field === 'business';
        });

        if (
            businessFilter &&
            businessFilter.field &&
            Array.isArray(dateRangers) &&
            dateRangers.length > 0
        ) {
            const joinFilters = filters.filter((filter: Filter) => {
                return filter.table === 'customize__loyaltychangelogs_transactionrecds';
            });
            const rangers = dateRangers.map((ranger: DateRangeFilter) => {
                const { field, tableAlias, startValue, endValue } = ranger;
                return `createdtime BETWEEN '${startValue}' AND '${endValue}'`;
            });
            return `SELECT receiptnumber FROM storehub_mongo.transactionrecords WHERE business='${
                businessFilter.value
            }' ${
                Array.isArray(joinFilters) && joinFilters.length > 0
                    ? `AND ${joinFilters.map((f) => `${f.field}='${f.value}'`).join('AND')}`
                    : ''
            } AND ${rangers.join('AND')}`;
        }
        return null;
    },
    customize__customer_transactionrecords: (
        filters: Filter[],
        dateRangers: DateRangeFilter[],
    ): string => {
        const businessFilter = filters.find((filter: Filter) => {
            return filter.field === 'business';
        });
        if (businessFilter && businessFilter.field) {
            const rangers =
                Array.isArray(dateRangers) && dateRangers.length > 0
                    ? dateRangers.map((ranger: DateRangeFilter) => {
                          const { field, tableAlias, startValue, endValue } = ranger;
                          return `${
                              tableAlias ? `${tableAlias}.` : ''
                          }${field} BETWEEN '${startValue}' AND '${endValue}'`;
                      })
                    : null;
            return `SELECT distinct customerid, storeid FROM storehub_mongo.transactionrecords WHERE business='${
                businessFilter.value
            }' ${rangers ? `AND ${rangers.join('AND')}` : ''}`;
        }
        return null;
    },
    customize__product_category_transactionrecords: (
        filters: Filter[],
        dateRangers: DateRangeFilter[],
    ): string => {
        const businessFilter = filters.find((filter: Filter) => {
            return filter.field === 'business';
        });
        if (businessFilter && businessFilter.field)
            return `SELECT original_id, category FROM storehub_mongo.products WHERE business='${businessFilter.value}'`;
        return null;
    },
};
