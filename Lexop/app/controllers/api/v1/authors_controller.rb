class API::V1::AuthorsController < API::APIController
  def index
    render json: {
      data: {
        authors: NewsArticle.distinct.order(:author).pluck(:author)
      }
    }
  end
end
