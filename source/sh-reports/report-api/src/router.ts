import express from 'express';

import { statsRouter } from './controllers/stats';
import { beepRouter } from './controllers/beep';
import { customersRouter } from './controllers/customers/router';
import { transactionrecordsRouter } from './controllers/transactionrecords/router';
import { loyaltychangelogsRouter } from './controllers/loyaltychangelogs/router';
import { employeesRouter } from './controllers/employees/router';
import { transformationsRouter } from './controllers/transformations/router';
import { suggestionsRouter } from './controllers/suggestions/router';
import { engageReportRouter } from './controllers/engageReport/router';
import { feedbackReportRouter } from './controllers/feedbackReport/router';
import { dashboardRouter } from './controllers/dashboard/router';
import { businessTagsRouter } from './controllers/businessTags/router';
import { newCustomersRouter } from './controllers/newCustomers/router';
import { countCustomersRouter } from './controllers/countCustomers/router';
import { membersReportRouter } from './controllers/membersReport/router';

const apiRouterGroup = express.Router();

const router = (app: any) => {
    app.get('/health', (req: express.Request, res: express.Response) => {
        res.json({ health: 'ok' });
    });

    app.use('/api', apiRouterGroup);

    statsRouter(apiRouterGroup);
    beepRouter(apiRouterGroup);
    transactionrecordsRouter(apiRouterGroup);
    customersRouter(apiRouterGroup);
    engageReportRouter(apiRouterGroup);
    loyaltychangelogsRouter(apiRouterGroup);
    employeesRouter(apiRouterGroup);
    transformationsRouter(apiRouterGroup);
    suggestionsRouter(apiRouterGroup);
    feedbackReportRouter(apiRouterGroup);
    dashboardRouter(apiRouterGroup);
    businessTagsRouter(apiRouterGroup);
    newCustomersRouter(apiRouterGroup);
    countCustomersRouter(apiRouterGroup);
    membersReportRouter(apiRouterGroup);
};

export default router;
