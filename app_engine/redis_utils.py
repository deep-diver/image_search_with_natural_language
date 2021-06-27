import redis
import os


class RedisConnect:
    def __init__(self):
        redis_host = os.environ.get("REDISHOST", "localhost")
        redis_port = int(os.environ.get("REDISPORT", 6379))
        self.redis_client = redis.Redis(host=redis_host, port=redis_port)

    def get_client(self):
        return self.redis_client
