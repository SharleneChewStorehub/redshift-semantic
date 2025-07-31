import { request } from '../../utils/request';

export let lastTransformationRun = new Date(new Date().getTime() - 20 * 60 * 1000).toISOString();

const getLastRunTimeRequest = () => {
    if (!process.env.LAST_SYNCTIME_API) return;

    const url = `${process.env.LAST_SYNCTIME_API}`;
    return request(url, 'GET', {}, {});
};

export async function getLastRunTime() {
    const resp = await getLastRunTimeRequest();

    if (resp && resp.data && new Date(resp.data.syncDate) > new Date(lastTransformationRun)) {
        lastTransformationRun = resp.data.syncDate;
    }
}
