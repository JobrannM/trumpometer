class AddEvenMoreColumnsToDailyAnalyses < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_analyses, :fox_trump_global_emotions, :text
    add_column :daily_analyses, :cnn_trump_global_emotions, :text
    add_column :daily_analyses, :nbc_trump_global_emotions, :text
    add_column :daily_analyses, :fox_trump_global_sentiment,:string, array: true, default: []
    add_column :daily_analyses, :cnn_trump_global_sentiment,:string, array: true, default: []
    add_column :daily_analyses, :nbc_trump_global_sentiment,:string, array: true, default: []
  end
end
