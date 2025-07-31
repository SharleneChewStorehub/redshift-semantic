import schedule from 'node-schedule';
import { getLastRunTime } from './controllers/transformations/jobs';

export function initSchedulers() {
    getLastRunTime();

    schedule.scheduleJob('* * * * *', () => {
        getLastRunTime();
    });
}
