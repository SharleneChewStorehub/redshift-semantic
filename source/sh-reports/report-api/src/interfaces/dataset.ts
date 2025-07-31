export type FieldFuncs =
    | 'MAX'
    | 'MIN'
    | 'AVG'
    | 'COUNT'
    | 'SUM'
    | 'MEDIAN'
    | 'ROUND'
    | 'HOUR'
    | 'DAY'
    | 'MONTH'
    | 'WEEK'
    | 'YEAR'
    | 'DISTINCT'
    | 'DAYOFWEEK'
    | 'HOUROFDAY'
    | 'COUNTDISTINCT';

export type GroupByTypes =
    | 'HOUR'
    | 'DAY'
    | 'MONTH'
    | 'YEAR'
    | 'TERM'
    | 'WEEK'
    | 'QUARTER'
    | 'HOUROFDAY'
    | 'DAYOFWEEK';

export type SortedOrders = 'ASC' | 'DESC' | 'desc' | 'asc';

export type FilterExperssions =
    | '='
    | '>='
    | '<='
    | '<>'
    | '!='
    | '<'
    | '>'
    | 'is'
    | 'is not'
    | 'is null'
    | 'is not null'
    | 'in'
    | 'not in'
    | 'date_range'
    | 'like'
    | 'not like';

export type FilterValues = string | number | boolean | string[] | number[];

export type Symbol = '+' | '-' | '*' | '/';

export type Filter = {
    schema?: string;
    table?: string;
    field: string;
    value?: FilterValues;
    expression: FilterExperssions;
    tableAlias?: string;
};

export type DateRangeFilter = {
    schema?: string;
    table?: string;
    field: string;
    startValue: FilterValues;
    endValue: FilterValues;
    tableAlias?: string;
};

export type Field = {
    schema?: string;
    table?: string;
    tableAlias?: string;
    field: string;
    functionName?: FieldFuncs;
    alias?: string;
};

export type Join = {
    table?: string;
    schema?: string;
    field: string;
    joinSchema?: string;
    joinTable: string;
    joinField: string;
    joinSql?: string;
    joinAlias?: string;
};

export type Sorted = {
    schema?: string;
    table?: string;
    field: string;
    order: SortedOrders;
    tableAlias?: string;
};

export type GroupBy = {
    schema?: string;
    table?: string;
    tableAlias?: string;
    alias?: string;
    field: string;
    type: GroupByTypes;
};

export type SymbolField = {
    schema?: string;
    table?: string;
    tableAlias?: string;
    field?: string;
    symbol?: Symbol;
    value?: string | number | boolean;
};

export type AdvancedField = {
    fields?: SymbolField[];
    condition?: {
        schema?: string;
        table?: string;
        field: string;
        expression: FilterExperssions;
        value: number | string | string[] | number[] | boolean;
        ifTrue?: SymbolField[];
        ifFalse?: SymbolField[];
    };
    functions?: FieldFuncs[];
    alias?: string;
};

export interface DatasetJson {
    table: string;
    schema: string;
    fields: Field[];
    advancedFields: AdvancedField[];
    filters: Filter[];
    joins?: Join[];
    leftJoins?: Join[];
    sorteds?: Sorted[];
    groupBys?: GroupBy[];
    dateRangers: DateRangeFilter[];
    timezone: string;
    page?: number;
    size?: number;
}

export interface RedshiftConfig {
    host: string;
    port: string;
    user: string;
    password: string;
    database: string;
}

export type ReqFilter = {
    name: string;
    expression: FilterExperssions;
    value: string | number | string[] | number[] | boolean;
    excludeTables?: string[];
};

export type ReqSort = {
    name: string;
    order: 'DESC' | 'ASC' | 'desc' | 'asc';
};

export type ReqDate = {
    field: string;
    table?: string;
    schema?: string;
    value: string;
};
