class AddMoreColumnsToDailyAnalyses < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_analyses, :fox_global_sentiment, :string, array: true, default: []
    add_column :daily_analyses, :cnn_global_sentiment, :string, array: true, default: []
    add_column :daily_analyses, :nbc_global_sentiment, :string, array: true, default: []
  end
end
