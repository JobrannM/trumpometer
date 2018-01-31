class AddColumnsToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :tweet_count, :integer
    add_column :articles, :tweet_timeframe, :string
    add_column :articles, :total_reach, :string
    add_column :articles, :total_impression, :string
    add_column :articles, :total_retweet, :string
    add_column :articles, :hashtag_cloud, :string, array: true, default: []
    add_column :articles, :word_cloud, :string, array: true, default: []
    add_column :articles, :trump_emotions, :text
    add_column :articles, :article_sentiment, :string, array: true, default: []
    add_column :articles, :article_emotions, :text
  end
end
