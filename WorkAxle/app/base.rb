require "roda"
require "json"
require "redis"
require "logger"

require_relative "config"
require_relative "handlers/ad_request"
require_relative "handlers/pop_request"


module App
  class Base < Roda

    logger = Logger.new(STDOUT)
    logger.level = Logger::WARN

    plugin :error_handler
    plugin :json
    plugin :not_found

    # Normally the assets would be served by a CDN
    plugin :static, ['/assets'], root: File.expand_path('../', __dir__)

    client = Redis.new(Config::REDIS)

    error do |e|
      logger.error(e.message)
      response.status = 500
      {
        error: {
          message: "There was an error processing your request",
        }
      }
    end

    not_found do
      response.status = 404
      {
        error: {
          message: "Not Found",
        }
      }
    end

    # Application routes
    route do |r|
      r.on "api" do
        # handles simulated ad requests
        r.get "ad_request", &Proc.new {
          App::Handler.ad_request(request, response, client)
        }

        # handles simulated Proof of Play (PoP) requests
        r.post "pop", String, &Proc.new { |request_id|
          App::Handler.pop_request(request, response, client, request_id)
        }
      end
    end
  end
end