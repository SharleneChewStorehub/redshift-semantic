import express from 'express';

import { getStats } from '../stats';

const stats = (req: express.Request, res: express.Response) => {
    res.json({ stats: getStats() });
};

export function statsRouter(router: any) {
    router.get('/stats', [], stats);
}
