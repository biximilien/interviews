class CreateNewsArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :news_articles do |t|
      t.string :title, null: false
      t.date :publication_date, null: false
      t.string :author, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
