class DailyAnalysesController < ApplicationController
  before_action :set_analysis

  # def show
  # end

  private

  def set_analysis
    @analysis = DailyAnalysis.last
  end
end
