import 'newrelic';
import express from 'express';

import compression from 'compression';
import bodyParser from 'body-parser';
import morgan from 'morgan';

import warehouse from './warehouse';
import router from './router';
import { Mongodb } from './database';
import { initStats } from './stats';
import { initSchedulers } from './schedulers';

initStats();
initSchedulers();
warehouse.init();

const mongodb = new Mongodb();
mongodb.start();

const app = express();

app.use(compression());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(morgan('[:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length]'));
router(app);

if (process.env.NODE_ENV !== 'production')
    app.use((req: any, res: any, next: Function) => {
        res.header('Access-Control-Allow-Origin', '*');
        res.header(
            'Access-Control-Allow-Headers',
            'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild',
        );
        res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');
        if (req.method === 'OPTIONS') {
            res.sendStatus(200);
        } else {
            next();
        }
    });

const server = app.listen(process.env.PORT, () => {
    console.log(`Node.js API server is listening on :${process.env.PORT}`);
});

// Shutdown Node.js app gracefully
function handleExit(
    options: {
        cleanup: boolean;
        exit: boolean;
    },
    err: Error,
) {
    if (options.cleanup) {
        const actions = [server.close];
        actions.forEach((close, i) => {
            try {
                close(() => {
                    if (i === actions.length - 1) process.exit();
                });
            } catch (err) {
                if (i === actions.length - 1) process.exit();
            }
        });
    }
    if (err) console.log(err);
    if (options.exit) process.exit();
}

process.on('exit', handleExit.bind(null, { cleanup: true }));
process.on('SIGINT', handleExit.bind(null, { exit: true }));
process.on('SIGTERM', handleExit.bind(null, { exit: true }));
process.on('uncaughtException', handleExit.bind(null, { exit: true }));
process.on('unhandledRejection', handleExit.bind(null, {}));
process.on('rejectionHandled', handleExit.bind(null, {}));
