class RenameColumnsInDailyAnalyses < ActiveRecord::Migration[5.1]
  def change
    rename_column :daily_analyses, :nbc_global_sentiment, :nbc_article_global_sentiment
    rename_column :daily_analyses, :fox_global_sentiment, :fox_article_global_sentiment
    rename_column :daily_analyses, :cnn_global_sentiment, :cnn_article_global_sentiment
    rename_column :daily_analyses, :nbc_global_emotions, :nbc_article_global_emotions
    rename_column :daily_analyses, :fox_global_emotions, :fox_article_global_emotions
    rename_column :daily_analyses, :cnn_global_emotions, :cnn_article_global_emotions
  end
end
