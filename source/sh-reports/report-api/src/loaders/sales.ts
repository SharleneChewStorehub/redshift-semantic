const businessTimezoneMap: { [key: string]: string } = {};

export function setBusinessTimezone(business: string, timezone: string) {
    businessTimezoneMap[business] = timezone;
}

export function getTimezoneByBusiness(business: string) {
    return businessTimezoneMap[business] || null;
}
