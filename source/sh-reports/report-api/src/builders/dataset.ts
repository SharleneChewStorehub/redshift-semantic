import {
    Filter,
    Join,
    Field,
    Sorted,
    GroupBy,
    DatasetJson,
    AdvancedField,
    DateRangeFilter,
    FieldFuncs,
} from '../interfaces/dataset';
import { relations, customizeRelations } from '../relations';
import timezoneNameToOffsets from 'timezone-name-offsets';

export default class DatasetJsonBuilder {
    table: string;
    schema: string;
    filters: Filter[];
    joins: Join[];
    leftJoins: Join[];
    sorteds: Sorted[];
    groupBys: GroupBy[];
    fields: Field[];
    advancedFields: AdvancedField[];
    dateRangers: DateRangeFilter[];
    joinedTables: Join[];
    joinedTableNames: { [key: string]: boolean };
    page: number;
    size: number;
    timezone: string;

    constructor(schema: string, table: string) {
        this.table = table;
        this.schema = schema;
        this.fields = [];
        this.filters = [];
        this.joins = [];
        this.leftJoins = [];
        this.advancedFields = [];
        this.groupBys = [];
        this.sorteds = [];
        this.dateRangers = [];
        this.joinedTables = [];
        this.joinedTableNames = {};
        this.timezone = '+0';
    }

    setTimezone(timezone: string) {
        this.timezone = `${timezoneNameToOffsets[timezone] / 60}` || '+08';
        if (this.timezone === '0') {
            this.timezone = 'UTC';
        }
    }

    setFilter(filter: Filter, isSetJoin: boolean = true) {
        const { schema, table } = filter;
        this.setJoin(table);
        this.filters.push(filter);
    }

    setDateRangeFilter(
        field: { schema?: string; table?: string; field: string },
        start: string,
        end: string,
    ) {
        const { schema, table } = field;
        if (table) this.setJoin(table);

        this.dateRangers.push({
            ...field,
            startValue: start,
            endValue: end,
        });
    }

    setField(field: Field, isSetJoin: boolean = true) {
        const { schema, table } = field;
        this.setJoin(table);
        this.fields.push(field);
    }

    setAdvancedField(advancedField: AdvancedField) {
        const { fields, condition } = advancedField;
        if (Array.isArray(fields) && fields.length > 0) {
            fields.forEach((field) => {
                const { table } = field;
                this.setJoin(table);
            });
        }
        if (condition) {
            if (
                condition.expression === 'date_range' &&
                this.dateRangers[0] &&
                Array.isArray(condition.value) &&
                !condition.value.length
            ) {
                condition.value = [
                    this.dateRangers[0].startValue,
                    this.dateRangers[0].endValue,
                ] as string[];
            }

            const { table, ifTrue, ifFalse } = condition;
            this.setJoin(table);

            if (Array.isArray(ifTrue) && ifTrue.length > 0) {
                ifTrue.forEach((ifTrueField) => {
                    const { table } = ifTrueField;
                    this.setJoin(table);
                });
            }

            if (Array.isArray(ifFalse) && ifFalse.length > 0) {
                ifFalse.forEach((ifFalseField) => {
                    const { table } = ifFalseField;
                    this.setJoin(table);
                });
            }
        }
        this.advancedFields.push(advancedField);
    }

    parseJoin() {
        const that = this;
        if (Array.isArray(this.joinedTables) && this.joinedTables.length > 0) {
            this.joinedTables.forEach(
                ({ schema, table, field, joinTable, joinField, joinSchema, joinAlias }) => {
                    if (joinTable.indexOf('customize__') !== -1 && customizeRelations[joinTable]) {
                        const joinSql = customizeRelations[joinTable](
                            that.filters,
                            that.dateRangers,
                        );
                        that.joins.push({
                            schema: schema || that.schema,
                            table,
                            field,
                            joinTable,
                            joinField,
                            joinSql,
                            joinSchema: joinSchema || that.schema,
                            joinAlias,
                        });
                    } else {
                        if (joinTable && joinField && field)
                            that.joins.push({
                                schema: schema || that.schema,
                                table,
                                field,
                                joinSchema: joinSchema || that.schema,
                                joinTable,
                                joinField,
                                joinAlias,
                            });
                    }
                },
            );
        }
    }

    setJoin(relatedTable: string, joinAlias?: string) {
        if (relatedTable && relatedTable !== this.table && relations[this.table][relatedTable]) {
            const joins = relations[this.table][relatedTable];
            joins.forEach((join) => {
                const key = `${join.table}_${join.joinTable}`;
                if (!this.joinedTableNames[key]) {
                    this.joinedTableNames[key] = true;
                    this.joinedTables.push({ ...join });
                }
            });
        }
    }

    setSorted(sorted: Sorted) {
        this.sorteds.push(sorted);
    }

    setGroupBy(groupBy: GroupBy) {
        const { schema, table, field, alias, type, tableAlias } = groupBy;
        this.setJoin(table, tableAlias);
        this.setField(
            {
                schema,
                table,
                field,
                alias,
                tableAlias,
                functionName: type !== 'TERM' ? (type as FieldFuncs) : undefined,
            },
            false,
        );
        this.groupBys.push(groupBy);
    }

    setPage(page: number) {
        this.page = page;
    }

    setSize(size: number) {
        this.size = size;
    }

    getJson(): DatasetJson {
        this.parseJoin();

        return {
            table: this.table,
            schema: this.schema,
            filters: this.filters,
            joins: this.joins,
            leftJoins: this.leftJoins,
            groupBys: this.groupBys,
            fields: this.fields,
            advancedFields: this.advancedFields,
            sorteds: this.sorteds,
            page: this.page,
            size: this.size,
            dateRangers: this.dateRangers,
            timezone: this.timezone,
        };
    }
}
