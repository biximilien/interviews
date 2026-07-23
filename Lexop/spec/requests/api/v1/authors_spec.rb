require 'rails_helper'

RSpec.describe "API::V1::Authors", type: :request do
  describe "GET /api/v1/authors" do
    it "returns http success" do
      get "/api/v1/authors"
      expect(response).to have_http_status(:success)
    end
  end
end
