class API::V1::NewsArticlesController < API::APIController

  # pagination
  include Pagy::Backend

  # if the file is not found in the data/ path we return an error 404
  rescue_from Errno::ENOENT, with: :not_found
  # Pagy raises errors when page is out of bounds, reply with error 400 (bad request)
  rescue_from Pagy::OverflowError, Pagy::VariableError, with: :bad_request

  before_action :set_articles, only: [:index]
  before_action :set_article, only: [:show]

  def index
    pagy, records = pagy(@articles)
    render json: { 
      data: {
        articles: (records.map do |article|
          {
            title: article.title,
            publication_date: article.publication_date,
            author: article.author,
            category: article.category,
            # cache the excerpt as it could be expensive to read from disk all the time
            excerpt: Rails.cache.fetch("news_articles_excerpt/#{article.title}") do
              read_excerpt(article.title)
            end
          }
        end),
        pagination: pagy_metadata(pagy)
      }
    }
  end

  def show
    render json: {
      data: {
        article: {
          title: @article.title,
          publication_date: @article.publication_date,
          author: @article.author,
          category: @article.category,
          # cache the html content as it could be expensive to read from disk all the time
          html_content: Rails.cache.fetch("news_articles_html/#{@article.title}") do
            read_html_content(params[:title])
          end
        }
      }
    }
  end

  private

  def set_article
    @article = NewsArticle.find_by(title: params[:title])
    raise ActionController::RoutingError.new('Not Found') if @article.nil?
  end

  def set_articles
    @articles = NewsArticle.all
    # allow filtering by author and category
    if params.include?(:author)
      @articles = @articles.where(author: params[:author])
    end
    if params.include?(:category)
      @articles = @articles.where(category: params[:category])
    end
  end

  def read_excerpt(title)
    # We'll use Nokogiri to parse the HTML fragment from the article file and return text without markup
    article_body = read_html_content(title)
    document = Nokogiri::HTML.fragment(article_body)
    document.text.truncate(200)
  end

  def title_to_data_path(title)
    # custom underscoring function
    title_path = [title.underscore.gsub(/\.|:|'|%/,'').gsub(/\s|-|\//, "_"), 'html'].join('.')
    File.join(Rails.root, 'data', title_path)
  end

  def read_html_content(title)
    File.read(title_to_data_path(title))
  end
end
