import moment from 'moment-timezone';

export function isDateStringInvalid(date: string) {
    return new Date(date).toString() === 'Invalid Date';
}

export function toFixedNumberProperties(Obj: any) {
    const tmp = Object.assign({}, Obj);
    for (const name of Object.getOwnPropertyNames(tmp)) {
        if (/Count$/.test(name)) {
            continue;
        }
        if (typeof tmp[name] === 'object') {
            tmp[name] = toFixedNumberProperties(tmp[name]);
        } else if (typeof tmp[name] === 'number') {
            tmp[name] = Number.parseFloat(tmp[name].toFixed(2));
        }
    }
    return tmp;
}

export function dateToUTC(date: string, timezone: string) {
    return moment.tz(date, timezone).utc().format('YYYY-MM-DD HH:mm:ss');
}

export function filterString(str: any) {
    let result = str;

    if (typeof str !== 'string') return str;

    // eslint-disable-next-line
    result = result.replace(/[\v\r\n|(\u000b)(\u0000)']/g, (match: string) => {
        switch (match) {
            case '|':
                return '%7C;';
            case "'":
                return '&#39;';
            case '\v':
                return '%0B;';
            case '\r':
            case '\n':
                return '%0A;';
            case '\u0000':
                return '';
            case '\u000b':
                return '';
            default:
                return match;
        }
    });

    return result;
}

export function parseFloatNumber(data: number | string | boolean, digits: number = 2) {
    if (typeof data === 'boolean') return data;
    if (typeof data === 'string') {
        data = parseFloat(data);
    }
    return parseFloat(data.toFixed(digits));
}
