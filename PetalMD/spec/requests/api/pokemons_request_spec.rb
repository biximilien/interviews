require 'rails_helper'
require 'json'

RSpec.describe "Pokemons", type: :request do

  describe "GET /api/pokemons" do
    it "returns http success" do
      get "/api/pokemons"
      expect(response).to have_http_status(:success)
      data = JSON.parse(response.body)
      expect(data).to be_an Hash
      expect(data['pokemons'].count).to eq 50
    end
  end

  context "when a page is given" do
    describe "GET /api/pokemons" do
      it "returns http success the paginated list" do
        get "/api/pokemons", params: { page: 5 }
        expect(response).to have_http_status(:success)
        data = JSON.parse(response.body)
        expect(data).to be_an Hash
        expect(data['pokemons'].count).to eq 50
      end
    end
  end

  describe "GET /api/pokemons/1" do
    it "returns http success" do
      get "/api/pokemons/1"
      expect(response).to have_http_status(:success)
      data = JSON.parse(response.body)
      expect(data).to be_a Hash
      expect(data['name']).to eq 'Bulbasaur'
    end
  end

  describe "POST /" do
    it "returns http success" do
      post "/api/pokemons", params: {
        pokemon: {
          number: '722',
          name: 'Pikablu',
          type_1: 'Water',
          type_2: 'Electric',
          total: 600,
          hp: 100,
          attack: 100,
          defense: 100,
          sp_atk: 100,
          sp_def: 100,
          speed: 100,
          generation: 1,
          legendary: true
        }
      }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT /api/pokemons/1" do
    it "returns http success" do
      put "/api/pokemons/1", params: { pokemon: { name: 'Bubasaur' }}
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/pokemons/1" do
    it "returns http success" do
      patch "/api/pokemons/1", params: { pokemon: { name: 'Bubusaur' }}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /api/pokemons/150" do
    it "returns http success (no content)" do
      delete "/api/pokemons/150"
      expect(response).to have_http_status(:no_content)
    end
  end

end
