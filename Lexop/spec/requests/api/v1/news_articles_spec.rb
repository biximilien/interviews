require 'rails_helper'

RSpec.describe "API::V1::NewsArticles", type: :request do
  describe "GET /api/v1/news_articles" do
    it "returns http success" do
      get "/api/v1/news_articles"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /api/v1/news_articles/:title" do
    context "when provided with a title parameter that exists as an article in data/ path" do
      it "returns http success" do
        get "/api/v1/news_articles/Montreal%20Hawks%20Minor%20League%20Baseball%20Team%20Wins%20Championship"
        expect(response).to have_http_status(:success)
      end
    end

    context "when the article does not exist" do
      it "returns http not found" do
        get "/api/v1/news_articles/Danielle%20Smith%20Elected%20As%20Alberta%20Prime%20Minister"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
