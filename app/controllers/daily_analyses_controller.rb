class DailyAnalysesController < ApplicationController
  before_action :set_analysis

 def show
  @fox_articles = DailyAnalysis.last.articles.where(medium_id:8)
  @cnn_articles = DailyAnalysis.last.articles.where(medium_id:9)
  @nbc_articles = DailyAnalysis.last.articles.where(medium_id:10)
 end



  private

  def set_analysis
    @analysis = DailyAnalysis.last
  end
end
