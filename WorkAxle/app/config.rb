module App
  class Config
    # Configuration for the application
    API_BASE_URL = ENV.fetch("API_BASE_URL", "http://localhost:9292").freeze

    # Redis configuration
    REDIS = {
      host: ENV.fetch("REDIS_HOST", "localhost").freeze,
      port: ENV.fetch("REDIS_PORT", 6379).freeze,
      db: ENV.fetch("REDIS_DB", 0).freeze
    }
  end
end