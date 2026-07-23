require "securerandom"

require_relative "../config"
require_relative "../asset"


module App::Handler

  ONE_HOUR_IN_SECONDS = 3600

  # Handles ad requests
  def self.ad_request(request, response, client)
    request_id = SecureRandom.uuid
    asset = App::Asset.random
    requested_at = Time.now.utc.to_i

    ad = {
      # Unique identifier for the ad request
      id: request_id,
      # The URL of the ad asset
      asset: asset.to_h,
      # The URL the Ad Player should call to confirm the ad was played
      pop_url: App::Config::API_BASE_URL + "/api/pop/" + request_id,
      # Request timestamp
      requested_at: requested_at,
      # Ads are valid for 1 hour
      expires_at: requested_at + asset.duration + ONE_HOUR_IN_SECONDS,
    }

    # Store the ad in Redis with a TTL of 1 hour
    client.set(request_id, ad.to_json, ex: ONE_HOUR_IN_SECONDS)

    # Return the ad in the response
    {
      ad: ad
    }
  end
end