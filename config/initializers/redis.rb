Redis.current = Redis.new(url: ENV['REDIS_URL_CACHING'] || 'redis://localhost:6379/0')
