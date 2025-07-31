import redis from 'redis';

const redisClient = redis.createClient(null, process.env.REDIS_HOST);

redisClient.on('error', (err: any) => console.log('Redis Client Error', err));

export default redisClient;
