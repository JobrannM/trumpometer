class DailyAnalysis < ApplicationRecord
  has_many :articles
  serialize :fox_article_global_emotions
  serialize :cnn_article_global_emotions
  serialize :nbc_article_global_emotions
  serialize :fox_trump_global_emotions
  serialize :cnn_trump_global_emotions
  serialize :nbc_trump_global_emotions
end
