class DailyAnalysis < ApplicationRecord
  has_many :articles
  serialize :fox_global_emotions
  serialize :cnn_global_emotions
  serialize :nbc_global_emotions
end
