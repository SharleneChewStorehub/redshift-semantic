export function errorResponse(err: any, res: any) {
    if (res) {
        if (err instanceof Error) {
            // eslint-disable-next-line
            console.log(err);
            res.status(500).json({ message: err.message || 'Server Error.' });
        } else if (err.code && err.message) {
            res.status(err.code).json({ message: err.message });
        } else {
            res.status(500).json(err);
        }
    } else {
        // eslint-disable-next-line
        console.log(err);
    }
}
