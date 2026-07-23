require_relative 'config'


module App
  class Asset

    # Mock data for assets
    ASSETS = [
      { id: "a7b5b188-201e-4afc-821a-62b8c0fc66d0", type: "image", url: App::Config::API_BASE_URL + "/assets/chili.png", duration: 10 },
      { id: "af1d4df6-455c-49a4-9edf-e5a7212f73b7", type: "image", url: App::Config::API_BASE_URL + "/assets/sandwich_bar.png", duration: 15 },
      { id: "28d17922-c1a4-4f85-85e9-e32f365136b1", type: "image", url: App::Config::API_BASE_URL + "/assets/shawarma.png", duration: 20 },
      { id: "69dba91c-6a86-4932-8640-3dbfd05518b8", type: "image", url: App::Config::API_BASE_URL + "/assets/smash_burger.png", duration: 15 },
      { id: "a643eb2a-dd29-47bb-8b40-6960a4933137", type: "image", url: App::Config::API_BASE_URL + "/assets/par_and_pint.png", duration: 10 },
      { id: "7bdfc4e9-0b28-4b46-9feb-f6c603fef2e2", type: "image", url: App::Config::API_BASE_URL + "/assets/sugar_saw.png", duration: 20 },
    ].freeze

    attr_accessor :id, :type, :url, :duration

    def initialize(id:, type:, url:, duration:)
      @id = id
      @type = type
      @url = url
      @duration = duration
    end

    def to_h
      {
        id: id,
        type: type,
        url: url,
        duration: duration
      }
    end

    def self.random
      # Randomly select an asset from the mock data
      new(**ASSETS.sample)
    end
  end
end