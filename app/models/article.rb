class Article < ApplicationRecord
  belongs_to :medium
  belongs_to :daily_analysis
end
