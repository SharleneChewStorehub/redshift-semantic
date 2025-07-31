import express from 'express';
import {
    DatasetJson,
    Field,
    AdvancedField,
    ReqFilter,
    ReqSort,
    ReqDate,
    Filter,
} from '../interfaces/dataset';
import DatasetJsonBuilder from '../builders/dataset';
import warehouse from '../warehouse';
import { isDateStringInvalid, dateToUTC } from './utils';
import { getTimezoneByBusiness, setBusinessTimezone } from '../loaders/sales';
import { timezones } from '../utils/timezones';
import moment from 'moment-timezone';
import _ from 'lodash';

const businessSchema = 'storehub_mongo';
const DbSourceMapping: { [key: string]: string } = {
    engageReport: 'postgresql',
    membersReport: 'postgresql',
};

const getAdvancedFieldsMap = (
    optionalMeasures: any,
    optionalAdvancedFields: any,
    fields: { field: Field; kind: 'field' } | { field: string[]; kind: 'advancedField' },
) => {
    let advancedFieldsMap: { [key: string]: AdvancedField } = {};
    if (Array.isArray(fields.field) && fields.field.length > 0) {
        fields.field.forEach((field) => {
            if (optionalMeasures[field]) {
                advancedFieldsMap = {
                    ...advancedFieldsMap,
                    ...getAdvancedFieldsMap(
                        optionalMeasures,
                        optionalAdvancedFields,
                        optionalMeasures[field],
                    ),
                };
            } else if (optionalAdvancedFields[field]) {
                advancedFieldsMap[field] = optionalAdvancedFields[field];
            }
        });
    }
    return advancedFieldsMap;
};

const getWarehouseJson = (
    name: string,
    schema: string,
    table: string,
    business?: string,
    startTime?: ReqDate,
    endTime?: ReqDate,
    additionalParams?: {
        groupBys?: string[];
        measures?: string[];
        filters?: ReqFilter[];
        timezone?: string;
        sorts?: ReqSort[];
        page: number;
        size: number;
    },
): DatasetJson => {
    const {
        selectedAdvancedFields,
        selectedFields,
        optionalFilters,
        optionalGroupBys,
        optionalMeasures,
        sortableFields,
        optionalAdvancedFields,
        bindFilters,
    } = require(`./${name}/constants`);

    const builder = new DatasetJsonBuilder(schema, table);

    if (business)
        builder.setFilter({
            field: 'business',
            expression: '=',
            value: business,
        });

    if (startTime && endTime) {
        const field: { field: string; table?: string; schema?: string } = {
            field: startTime.field,
        };
        if (startTime.table) field.table = startTime.table;
        if (startTime.schema) field.schema = startTime.schema;
        builder.setDateRangeFilter(field, startTime.value, endTime.value);
    }

    if (selectedAdvancedFields && typeof selectedAdvancedFields === 'object')
        Object.keys(selectedAdvancedFields).forEach((key) => {
            builder.setAdvancedField({ ...selectedAdvancedFields[`${key}`], alias: key });
        });

    if (selectedFields && typeof selectedFields === 'object')
        Object.keys(selectedFields).forEach((key) => {
            builder.setField({ ...selectedFields[`${key}`], alias: key });
        });

    if (additionalParams) {
        if (additionalParams.timezone) {
            builder.setTimezone(additionalParams.timezone);
        }

        if (Array.isArray(additionalParams.groupBys) && additionalParams.groupBys.length > 0) {
            additionalParams.groupBys.forEach((groupBy: string) => {
                builder.setGroupBy(optionalGroupBys[groupBy]);
            });
        }

        if (Array.isArray(additionalParams.measures) && additionalParams.measures.length > 0) {
            let advancedFieldsMap: { [key: string]: AdvancedField } = {};
            additionalParams.measures.forEach((measure: string) => {
                if (optionalMeasures[measure]) {
                    const { kind, field } = optionalMeasures[measure];
                    if (kind === 'field') {
                        // Field bindFilters
                        if (bindFilters && Object.keys(bindFilters).includes(field)) {
                            additionalParams.filters = [
                                ...bindFilters[field],
                                ...(Array.isArray(additionalParams.filters)
                                    ? additionalParams.filters
                                    : []),
                            ];
                        }

                        builder.setField(field as Field);
                    } else if (optionalMeasures[measure].kind === 'advancedField') {
                        advancedFieldsMap = {
                            ...advancedFieldsMap,
                            ...getAdvancedFieldsMap(
                                optionalMeasures,
                                optionalAdvancedFields,
                                optionalMeasures[measure],
                            ),
                        };
                    }
                } else if (optionalAdvancedFields[measure]) {
                    advancedFieldsMap[measure] = _.cloneDeep(optionalAdvancedFields[measure]);
                } else if (measure === 'ALL') {
                    advancedFieldsMap = optionalAdvancedFields;
                }
            });

            Object.keys(advancedFieldsMap).forEach((key) => {
                if (advancedFieldsMap[key]) {
                    builder.setAdvancedField({ ...advancedFieldsMap[key], alias: key });
                }

                // AdvancedField bindFilters
                if (bindFilters && Object.keys(bindFilters).includes(key)) {
                    additionalParams.filters = [
                        ...bindFilters[key],
                        ...(Array.isArray(additionalParams.filters)
                            ? additionalParams.filters
                            : []),
                    ];
                }
            });
        }

        if (Array.isArray(additionalParams.filters) && additionalParams.filters.length > 0) {
            additionalParams.filters.forEach(({ name, expression, value }) => {
                if (name && expression && optionalFilters[name]) {
                    const filter: Filter = {
                        field: optionalFilters[name].field,
                        expression,
                        value,
                    };
                    if (optionalFilters[name].table) {
                        filter.table = optionalFilters[name].table;
                    }
                    builder.setFilter(filter);
                }
            });
        }

        if (Array.isArray(additionalParams.sorts) && additionalParams.sorts.length > 0) {
            additionalParams.sorts.forEach((sort) => {
                if (Object.keys(sortableFields).includes(sort.name)) {
                    builder.setSorted({
                        ...sortableFields[sort.name],
                        order: sort.order,
                    });
                } else {
                    builder.setSorted({
                        field: sort.name,
                        order: sort.order,
                    });
                }
            });
        }

        if (additionalParams.page && additionalParams.size) {
            builder.setPage(additionalParams.page);
            builder.setSize(additionalParams.size);
        }
    }

    return builder.getJson();
};

const getWarehouseResponse = async (
    name: string,
    schema: string,
    table: string,
    req: express.Request,
    businessTimezone: boolean = true,
) => {
    const {
        selectedAdvancedFields,
        selectedFields,
        selectedFilters,
        optionalFilters,
        optionalGroupBys,
        optionalMeasures,
        optionalAdvancedFields,
        dateField,
    } = require(`./${name}/constants`);

    const groupBys: string[] = [];
    const measures: string[] = [];
    const filters: ReqFilter[] = [];
    const sorts: ReqSort[] = [];
    let page: number = 0;
    let size: number = 0;
    let startDate = undefined;
    let endDate = undefined;
    let { business } = req.body;
    let timezone = 'Etc/UTC';
    let operationHours = req.body.operationHours || 0;
    business = business ? business.toLocaleLowerCase() : null;

    if (business && businessTimezone) {
        timezone = getTimezoneByBusiness(business);
        if (!timezone) {
            timezone = await warehouse.getTimezone(
                DbSourceMapping[name] || 'redshift',
                DbSourceMapping[name] ? 'transformations' : businessSchema,
                business,
            );
            setBusinessTimezone(business, timezone);
        }

        // @ts-ignore
        const timezoneOffset: number = moment.tz('2020-01-01', timezone)._offset;
        timezone = timezones[(operationHours - timezoneOffset / 60).toString()];
    }

    if (req.body.startTime && req.body.endTime) {
        if (isDateStringInvalid(req.body.startTime) || isDateStringInvalid(req.body.endTime)) {
            throw new Error('[ReqError]: startTime or endTime invalid');
        } else if (dateField) {
            const { field, table } = dateField;
            startDate = {
                field,
                table,
                value: dateToUTC(req.body.startTime, timezone),
            };
            endDate = {
                field,
                table,
                value: dateToUTC(req.body.endTime, timezone),
            };
        }
    }

    if (Array.isArray(req.body.groupBys) && req.body.groupBys.length > 0) {
        req.body.groupBys.forEach((groupBy: string) => {
            if (Object.keys(optionalGroupBys).includes(groupBy)) groupBys.push(groupBy);
        });
    }

    if (Array.isArray(req.body.measures) && req.body.measures.length > 0) {
        req.body.measures.forEach((measure: string) => {
            if (
                measure === 'ALL' ||
                Object.keys(optionalMeasures).includes(measure) ||
                Object.keys(optionalAdvancedFields).includes(measure)
            )
                measures.push(measure);
        });
    }

    if (Array.isArray(selectedFilters) && selectedFilters.length > 0) {
        const filterNames = Array.isArray(req.body.filters)
            ? req.body.filters.map((filter: ReqFilter) => filter.name)
            : [];

        const defaultFilters = selectedFilters.filter((filter: ReqFilter) => {
            return (
                !filterNames.includes(filter.name) &&
                (!Array.isArray(filter.excludeTables) || !filter.excludeTables.includes(table))
            );
        });

        req.body.filters = [
            ...defaultFilters,
            ...(Array.isArray(req.body.filters) ? req.body.filters : []),
        ];
    }

    if (Array.isArray(req.body.filters) && req.body.filters.length > 0) {
        req.body.filters.forEach((filter: ReqFilter) => {
            if (
                filter.name &&
                Object.keys(optionalFilters).includes(filter.name) &&
                filter.value !== undefined
            ) {
                filters.push(filter);
            }
        });
    }

    if (Array.isArray(req.body.sorts) && req.body.sorts.length > 0) {
        req.body.sorts.forEach((sort: ReqSort) => {
            if (
                (Object.keys(selectedFields).includes(sort.name) ||
                    Object.keys(selectedAdvancedFields).includes(sort.name) ||
                    Object.keys(optionalMeasures).includes(sort.name) ||
                    Object.keys(optionalAdvancedFields).includes(sort.name) ||
                    Object.keys(optionalGroupBys).includes(sort.name) ||
                    Object.keys(optionalGroupBys)
                        .map((key) => optionalGroupBys[key].alias)
                        .includes(sort.name)) &&
                ['DESC', 'ASC', 'desc', 'asc'].includes(sort.order)
            )
                sorts.push(sort);
        });
    }

    if (
        req.body.size &&
        req.body.page &&
        Number.isInteger(req.body.size) &&
        Number.isInteger(req.body.page)
    ) {
        size = req.body.size;
        page = req.body.page;
    }

    const query = warehouse.parseJsonToSql(
        getWarehouseJson(name, schema, table, business, startDate, endDate, {
            groupBys,
            measures,
            filters,
            timezone,
            sorts,
            page,
            size,
        }),
        operationHours,
    );

    const resp = await warehouse.sendQuery(DbSourceMapping[name] || 'redshift', query);
    return resp && Array.isArray(resp.rows) && resp.rows.length > 0 ? resp.rows : [];
};

export default {
    getWarehouseResponse,
    getAdvancedFieldsMap,
};
