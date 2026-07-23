class API::V1::CategoriesController < API::APIController
  def index
    render json: {
      data: {
        categories: NewsArticle.distinct.order(:category).pluck(:category)
      }
    }
  end
end
