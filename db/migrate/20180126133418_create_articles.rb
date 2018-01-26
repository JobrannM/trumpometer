class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.string :trump_sentiment
      t.date :publication_date
      t.string :author
      t.references :medium, foreign_key: true

      t.timestamps
    end
  end
end
