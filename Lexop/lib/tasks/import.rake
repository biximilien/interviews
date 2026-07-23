require 'csv'

namespace :import do
  desc "Imports a list of news articles from a csv file"
  task :news_articles, [:csv_path] => [:environment] do |task, args|
    news_articles = []
    CSV.foreach(args.csv_path, headers: true) do |line|

      # could be useful when debugging
      Rails.logger.debug(line)
      
      begin
        # never hurts to be verbose here
        news_articles << { 
          title: String(line["title"]),
          publication_date: Date.parse(String(line["publication_date"])),
          author: String(line["author"]),
          category: String(line["category"]),
          # like_counts_per_date: line["like_counts_per_date"] # TODO: design a model for like counts
        }

      # handle runtime errors, malformed dates or CSV rows
      rescue Date::Error, CSV::MalformedCSVError => e
        Rails.logger.error(e.message)
        Rails.logger.error(e.backtrace.join("\n"))
      end
    end

    # Batch create news articles
    # it should not create new articles if the data fails validation
    NewsArticle.create!(news_articles)
  end

end
