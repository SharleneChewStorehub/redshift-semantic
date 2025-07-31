type Stats = {
    startTime?: string;
    query?: {
        count: number;
        costTime: number;
        averageTime: number;
    };
    errors?: {
        query: string;
        message: string;
    }[];
};

const stats: Stats = {};

export function initStats() {
    stats.startTime = new Date().toString();
    stats.query = {
        count: 0,
        averageTime: 0,
        costTime: 0,
    };
    stats.errors = [];
}

export function pushQuery(runtime: number) {
    stats.query.costTime += runtime;
    stats.query.count += 1;
    stats.query.averageTime = Math.floor((stats.query.costTime / stats.query.count) * 100) / 100;
}

export function pushError(query: string, message: string) {
    stats.errors.push({
        query,
        message,
    });
}

export function getStats() {
    return stats;
}
