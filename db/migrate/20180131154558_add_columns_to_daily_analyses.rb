class AddColumnsToDailyAnalyses < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_analyses, :fox_global_emotions, :text
    add_column :daily_analyses, :cnn_global_emotions, :text
    add_column :daily_analyses, :nbc_global_emotions, :text
  end
end
