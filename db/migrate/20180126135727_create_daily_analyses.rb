class CreateDailyAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_analyses do |t|
      t.date :day
      t.string :fox_global_sentiment
      t.string :msnbc_global_sentiment
      t.string :cnn_global_sentiment
      t.integer :rt_global_sentiment

      t.timestamps
    end
  end
end
