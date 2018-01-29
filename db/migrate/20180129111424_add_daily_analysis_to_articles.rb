class AddDailyAnalysisToArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :daily_analysis, foreign_key: true
  end
end
