import { DatasetJson, AdvancedField } from '../../interfaces/dataset';

export function getTimezoneSql(schema: string, business: string) {
    return `SELECT timezone FROM ${schema}.businesses WHERE name='${business}'`;
}

export function getStoreListSql(schema: string, business: string) {
    return `SELECT _id, name, isdeleted FROM ${schema}.businesses__stores WHERE businesses_foreignkey=(SELECT _id FROM ${schema}.businesses WHERE name='${business}')`;
}

export function parseJsonToSql(json: DatasetJson, operationHours: number) {
    const {
        filters,
        fields,
        advancedFields,
        joins,
        leftJoins,
        groupBys,
        sorteds,
        page,
        dateRangers,
        size,
        timezone,
    } = json;
    const mainTable = json.table;
    const mainSchema = json.schema;

    const dateRangerStrings: string[] = [];
    if (Array.isArray(dateRangers) && dateRangers.length > 0) {
        dateRangers.forEach(({ schema, table, field, startValue, endValue, tableAlias }) => {
            if (table && table.indexOf('customize__') !== -1) return;
            dateRangerStrings.push(
                `${
                    tableAlias ? tableAlias : `"${schema || mainSchema}"."${table || mainTable}"`
                }."${field}" BETWEEN '${startValue}' AND '${endValue}'`,
            );
        });
    }

    const businessFilter: string[] = [];
    const filterStrings: string[] = [];
    const joinedFilterStrings: string[] = [];
    if (Array.isArray(filters) && filters.length > 0) {
        filters.forEach(({ schema, table, field, expression, value, tableAlias }) => {
            if (table && table.indexOf('customize__') !== -1) return;

            let result = '';
            switch (expression) {
                case 'is not null':
                case 'is null':
                    result = `"${schema || mainSchema}"."${
                        table || mainTable
                    }"."${field}" ${expression}`;
                    break;
                case 'not in':
                case 'in':
                    if (Array.isArray(value) && value.length > 0) {
                        const inString: any[] = [];
                        value.forEach((v: string | number) => {
                            if (typeof v === 'string') {
                                inString.push(`'${v}'`);
                            } else {
                                inString.push(v);
                            }
                        });

                        if (
                            [
                                'customer_firstname',
                                'customer_lastname',
                                'customer_email',
                                'customer_phone',
                                'customer_tags',
                            ].includes(field) &&
                            expression === 'not in'
                        ) {
                            result = `COALESCE("${schema || mainSchema}"."${
                                table || mainTable
                            }"."${field}",'') ${expression} (${inString.join(',')})`;
                        } else {
                            result = `"${schema || mainSchema}"."${
                                table || mainTable
                            }"."${field}" ${expression} (${inString.join(',')})`;
                        }
                    }
                    break;
                case 'like':
                    const likeValues = Array.isArray(value) ? value : value.toString().split(',');
                    const likeConditions = likeValues
                        .map(
                            (val) =>
                                `CHARINDEX('${val}', "${schema || mainSchema}"."${
                                    table || mainTable
                                }"."${field}") <> 0`,
                        )
                        .join(' OR ');

                    result = `(${likeConditions})`;
                    break;
                case 'not like':
                    const notLikeValues = Array.isArray(value)
                        ? value
                        : value.toString().split(',');
                    const notLikeConditions = notLikeValues
                        .map(
                            (val) =>
                                `CHARINDEX('${val}', COALESCE("${schema || mainSchema}"."${
                                    table || mainTable
                                }"."${field}",'')) = 0`,
                        )
                        .join(' AND ');
                    result = `(${notLikeConditions})`;
                    break;
                case 'date_range':
                    if (Array.isArray(value) && value.length > 0) {
                        const startValue = value[0];
                        const endValue = value[1];
                        result = `"${field}" BETWEEN ${startValue} AND ${endValue}`;
                    }

                    break;
                default:
                    if (table && table.indexOf('customize__') !== -1) {
                        result = `${tableAlias || table}."${field}" ${expression} ${
                            typeof value === 'string' ? `'${value}'` : value
                        }`;
                    }

                    result = `"${schema || mainSchema}"."${
                        table || mainTable
                    }"."${field}" ${expression} ${
                        typeof value === 'string' ? `'${value}'` : value
                    }`;
                    break;
            }

            if (result) {
                if ((table && table !== mainTable) || (schema && schema !== mainSchema))
                    joinedFilterStrings.push(result);
                else if (field === 'business') {
                    businessFilter.push(result);
                } else filterStrings.push(result);
            }
        });
    }
    const filterString = [
        ...businessFilter,
        ...dateRangerStrings,
        ...filterStrings,
        ...joinedFilterStrings,
    ].join(' AND ');

    const groupByString =
        Array.isArray(groupBys) && groupBys.length > 0
            ? groupBys
                  .map(({ schema, table, field, type, tableAlias }) => {
                      const fieldString = `${
                          tableAlias
                              ? tableAlias
                              : `"${schema || mainSchema}"."${table || mainTable}"`
                      }."${field}"`;
                      switch (type) {
                          case 'YEAR':
                          case 'MONTH':
                          case 'HOUR':
                          case 'WEEK':
                          case 'QUARTER':
                          case 'DAY':
                              return `CONVERT_TIMEZONE('8', '${timezone}', DATE_TRUNC('${type}', CONVERT_TIMEZONE('${timezone}', '0', ${fieldString})))`;
                          case 'DAYOFWEEK':
                              return `DATE_PART('${type}', CONVERT_TIMEZONE('${timezone}', '0', ${fieldString}))`;
                          case 'HOUROFDAY':
                              let timezoneNum = timezone;
                              if (timezone === 'UTC') {
                                  timezoneNum = '0';
                              }
                              return `DATE_PART('hour', CONVERT_TIMEZONE('${
                                  operationHours
                                      ? parseInt(timezoneNum, 10) + operationHours
                                      : timezoneNum
                              }', '0', ${fieldString}))`;
                          default:
                              return fieldString;
                      }
                  })
                  .join(',')
            : '';

    const fieldsString =
        Array.isArray(fields) && fields.length > 0
            ? fields
                  .map(({ schema, table, field, functionName, alias, tableAlias }) => {
                      const fieldString = `${
                          tableAlias
                              ? tableAlias
                              : `"${schema || mainSchema}"."${table || mainTable}"`
                      }."${field}"`;
                      const aliasString = `${alias ? ` AS ${alias}` : ''}`;
                      switch (functionName) {
                          case 'MIN':
                          case 'AVG':
                          case 'COUNT':
                          case 'SUM':
                          case 'MEDIAN':
                          case 'ROUND':
                          case 'MAX':
                          case 'DISTINCT':
                              return `${functionName}(${fieldString})${aliasString}`;
                          case 'COUNTDISTINCT':
                              return `COUNT(DISTINCT(${fieldString}))${aliasString}`;
                          case 'HOUR':
                          case 'YEAR':
                          case 'MONTH':
                          case 'WEEK':
                          case 'DAY':
                              return `CONVERT_TIMEZONE('8', '${timezone}', DATE_TRUNC('${functionName}', CONVERT_TIMEZONE('${timezone}', '0',${fieldString})))${aliasString}`;
                          case 'DAYOFWEEK':
                              return `DATE_PART('${functionName}', CONVERT_TIMEZONE('${timezone}', '0',${fieldString}))${aliasString}`;
                          case 'HOUROFDAY':
                              let timezoneNum = timezone;
                              if (timezone === 'UTC') {
                                  timezoneNum = '0';
                              }
                              return `DATE_PART('hour', CONVERT_TIMEZONE('${
                                  operationHours
                                      ? parseInt(timezoneNum, 10) + operationHours
                                      : timezoneNum
                              }', '0',${fieldString}))${aliasString}`;
                          default:
                              return `${fieldString}${aliasString}`;
                      }
                  })
                  .join(',')
            : '';

    const advancedFieldsString =
        Array.isArray(advancedFields) && advancedFields.length > 0
            ? advancedFields.map((advancedField: AdvancedField) => {
                  let fieldStr: string;
                  if (Array.isArray(advancedField.fields) && advancedField.fields.length > 0) {
                      fieldStr = advancedField.fields
                          .map((field) => {
                              if (field.value !== undefined) {
                                  return typeof field.value === 'string'
                                      ? `'${field.value}'`
                                      : field.value;
                              } else {
                                  return `${field.symbol || ''}${
                                      field.tableAlias
                                          ? field.tableAlias
                                          : `"${field.schema || mainSchema}"."${
                                                field.table || mainTable
                                            }"`
                                  }."${field.field}"`;
                              }
                          })
                          .join('');
                  } else if (advancedField.condition) {
                      const { schema, table, field, expression, value, ifTrue, ifFalse } =
                          advancedField.condition;
                      let valueString = '';
                      if (Array.isArray(value) && value.length > 0) {
                          const valueArr: any[] = [];
                          value.forEach((v: any) => {
                              valueArr.push(
                                  `${
                                      typeof v === 'string' &&
                                      !v.includes('DATEADD') &&
                                      !v.includes('"')
                                          ? `'${v}'`
                                          : v
                                  }`,
                              );
                          });

                          if (expression === 'date_range') {
                              valueString = `BETWEEN ${valueArr[0]} AND ${valueArr[1]}`;
                          } else valueString = valueArr.join(',');
                      } else {
                          valueString = `${typeof value === 'string' ? `'${value}'` : value}`;
                      }

                      const ifTrueString =
                          Array.isArray(ifTrue) && ifTrue.length > 0
                              ? ifTrue
                                    .map((field) => {
                                        if (field.value !== undefined) {
                                            return typeof field.value === 'string'
                                                ? `'${field.value}'`
                                                : field.value;
                                        } else {
                                            return `${field.symbol || ''}${
                                                field.tableAlias
                                                    ? field.tableAlias
                                                    : `"${field.schema || mainSchema}"."${
                                                          field.table || mainTable
                                                      }"`
                                            }."${field.field}"`;
                                        }
                                    })
                                    .join('')
                              : '';

                      const ifFalseString =
                          Array.isArray(ifFalse) && ifFalse.length > 0
                              ? ifFalse
                                    .map((field) => {
                                        if (field.value !== undefined) {
                                            return typeof field.value === 'string'
                                                ? `'${field.value}'`
                                                : field.value;
                                        } else {
                                            return `${field.symbol || ''}${
                                                field.tableAlias
                                                    ? field.tableAlias
                                                    : `"${field.schema || mainSchema}"."${
                                                          field.table || mainTable
                                                      }"`
                                            }."${field.field}"`;
                                        }
                                    })
                                    .join('')
                              : '';

                      let expressionString = '';
                      switch (expression) {
                          case 'is not null':
                          case 'is null':
                              expressionString = expression;
                              break;
                          case 'not in':
                          case 'in':
                              expressionString = `${expression} (${valueString})`;
                              break;
                          case 'date_range':
                              expressionString = ` ${valueString}`;
                              break;
                          default:
                              expressionString = `${expression}${valueString}`;
                      }

                      if (
                          expression === 'date_range' ||
                          (Array.isArray(advancedField.functions) &&
                              !advancedField.functions.includes('SUM'))
                      ) {
                          fieldStr = `CASE WHEN "${schema || mainSchema}"."${
                              table || mainTable
                          }"."${field}"${expressionString} THEN ${ifTrueString} END`;
                      } else {
                          fieldStr = `CASE WHEN "${schema || mainSchema}"."${
                              table || mainTable
                          }"."${field}"${expressionString} THEN COALESCE(${ifTrueString},0) ELSE COALESCE(${ifFalseString},0) END`;
                      }
                  }

                  if (Array.isArray(advancedField.functions) && advancedField.functions.length > 0)
                      advancedField.functions.forEach((func) => {
                          fieldStr = `${func}(${fieldStr})`;
                      });

                  return `${fieldStr}${advancedField.alias ? ` AS ${advancedField.alias}` : ''}`;
              })
            : '';

    const joinString =
        Array.isArray(joins) && joins.length > 0
            ? joins
                  .map(
                      ({
                          schema,
                          table,
                          field,
                          joinSchema,
                          joinTable,
                          joinField,
                          joinSql,
                          joinAlias,
                      }) => {
                          const aliasString = joinAlias ? `AS ${joinAlias}` : '';

                          if (joinSchema && joinTable && !joinSql)
                              return `JOIN "${joinSchema}"."${joinTable}" ${aliasString}
                                ON ${
                                    joinAlias || joinTable
                                }."${joinField}"="${schema}"."${table}"."${field}"`;
                          else if (joinTable && joinSql && joinSchema) {
                              return `JOIN (${joinSql}) ${aliasString}
                                ON ${
                                    joinAlias || joinTable
                                }."${joinField}"="${schema}"."${table}"."${field}"`;
                          }
                      },
                  )
                  .join('\n')
            : '';

    const letfJoinString =
        Array.isArray(leftJoins) && leftJoins.length > 0
            ? leftJoins
                  .map(
                      ({
                          schema,
                          table,
                          field,
                          joinSchema,
                          joinTable,
                          joinField,
                          joinSql,
                          joinAlias,
                      }) => {
                          if (joinSchema && joinTable && !joinSql)
                              return `LEFT JOIN "${joinSchema}"."${joinTable}"
                          ON "${joinSchema}"."${joinTable}"."${joinField}"="${schema}"."${table}"."${field}"`;
                          else if (joinTable && joinSql && joinSchema) {
                              return `LEFT JOIN (${joinSql}) AS ${joinAlias || joinTable}
                          ON ${
                              joinAlias || joinTable
                          }."${joinField}"="${schema}"."${table}"."${field}"`;
                          }
                      },
                  )
                  .join('\n')
            : '';

    const orderByString =
        Array.isArray(sorteds) && sorteds.length > 0
            ? sorteds
                  .map(({ schema, table, field, order, tableAlias }) => {
                      return `${
                          tableAlias
                              ? `${tableAlias}.`
                              : `${schema && table ? `"${schema}"."${table}."` : ''}"`
                      }${field}" ${order}`;
                  })
                  .join(',')
            : '';

    return `SELECT ${fieldsString}${
        advancedFieldsString ? `,${advancedFieldsString}` : ''
    } FROM "${mainSchema}"."${mainTable}"
            ${joinString} ${letfJoinString}
            WHERE ${filterString}
            ${groupByString ? `GROUP BY ${groupByString}` : ''}
            ${orderByString ? `ORDER BY ${orderByString}` : ''}
            ${size ? `LIMIT ${size}` : ''}
            ${size && page ? `OFFSET ${(page - 1) * size}` : ''}`;
}
