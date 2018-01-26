class DailyAnalysesController < ApplicationController
  before_action :set_analysis
  def show
  end

  private

  def set_analysis
    @analysis = Daily_analyses.last
  end
end
