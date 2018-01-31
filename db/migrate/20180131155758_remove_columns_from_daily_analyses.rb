class RemoveColumnsFromDailyAnalyses < ActiveRecord::Migration[5.1]
  def change
    remove_column :daily_analyses, :fox_global_sentiment
    remove_column :daily_analyses, :cnn_global_sentiment
    remove_column :daily_analyses, :nbc_global_sentiment
  end
end
