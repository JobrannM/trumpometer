class Article < ApplicationRecord
  belongs_to :medium
  belongs_to :daily_analysis
  serialize :article_emotions
  serialize :trump_emotions
end
