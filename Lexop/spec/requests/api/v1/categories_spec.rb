require 'rails_helper'

RSpec.describe "API::V1::Categories", type: :request do
  describe "GET /api/v1/categories" do
    it "returns http success" do
      get "/api/v1/categories"
      expect(response).to have_http_status(:success)
    end
  end

end
