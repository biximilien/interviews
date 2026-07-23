require "securerandom"

require_relative "../config"
require_relative "../asset"


module App::Handler

  # handles Proof of Play (PoP) requests
  def self.pop_request(request, response, client, request_id)
    # retrieve the ad from our Redis store
    ad = client.get(request_id)

    # Check if the ad exists
    if ad.nil?
      response.status = 404
      return
    end

    # Ad is stored as a JSON string, so we need to parse it
    ad = JSON.parse(ad, symbolize_names: true)

    # Check if the ad is being played too early
    # In a real-world scenario, this would be logged for audit purposes
    # and bad actors would be penalized
    if Time.now.utc.to_i < ad[:requested_at] + ad[:asset][:duration]
      response.status = 400 # Bad Request
      return
    end

    # Check if the ad has expired
    # In a real-world scenario, this would also be logged for audit purposes
    if Time.now.utc.to_i > ad[:expires_at]
      response.status = 410 # Gone
      return
    end


    # Mock process for the Proof of Play
    # In a real-world scenario, this would involve more complex logic
    # such as updating a database, logging, audit, etc.
    # For the sake of this example, we will just increment a counter
    client.pipelined do
      client.del(request_id) # Delete the ad from Redis
      client.incr("pop_count") # Increment the PoP count
    end

    response.status = 204
    nil
  end
end