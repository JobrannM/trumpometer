class RenameColumnInDailyAnalyses < ActiveRecord::Migration[5.1]
  def change
    rename_column :daily_analyses, :msnbc_global_sentiment, :nbc_global_sentiment
  end
end
