require 'rails_helper'

RSpec.describe "Players", type: :request do

  before(:all) do
    rrjd = RushingRecordJSONDeserializer.new('db/data/rushing.json')
    rrjd.import
  end

  # GET /api/v1/players
  describe "GET /api/v1/players" do
    it "renders a list of players as JSON" do
      get api_v1_players_path
      expect(response).to have_http_status(:success)
      data = JSON.parse(response.body)
      players = data["players"]
      expect(players.count).to be 50
      player = players.first
      expect(player["player"]).to eq 'Wendell Smallwood'
    end
  end

  # GET /api/v1/players.json
  describe "GET /api/v1/players.json" do
    it "renders a list of players as JSON" do
      get api_v1_players_path
      expect(response).to have_http_status(:success)
      data = JSON.parse(response.body)
      players = data["players"]
      expect(players.count).to be 50
      player = players.first
      expect(player["player"]).to eq 'Wendell Smallwood'
    end
  end

  # GET /api/v1/players.csv
  describe "GET /api/v1/players.csv" do
    it "renders a list of players as CSV" do
      get api_v1_players_path
      expect(response).to have_http_status(:success)
    end
  end
end
