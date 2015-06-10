class SummaryController < ApplicationController
  def index
    @locations = Location.all.includes(:floor_plans)
  end

end