class DailyAnalysesController < ApplicationController
  before_action :set_analysis

 def show
  @fox_articles = DailyAnalysis.last.articles.joins(:medium).where(media: { name: "Fox News" })
  @cnn_articles = DailyAnalysis.last.articles.joins(:medium).where(media: { name: "CNN" })
  @nbc_articles = DailyAnalysis.last.articles.joins(:medium).where(media: { name: "NBC News" })
 end



  private

  def set_analysis
    @analysis = DailyAnalysis.last
  end
end
