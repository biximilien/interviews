class NewsArticle < ApplicationRecord

    validates :title,
        uniqueness: { case_sensitive: false },
        presence: true,
        allow_blank: false

    validates :publication_date,
        presence: true

    validates :author,
        presence: true,
        allow_blank: false

    validates :category,
        presence: true,
        allow_blank: false

end
