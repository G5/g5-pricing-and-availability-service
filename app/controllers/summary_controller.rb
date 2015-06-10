class SummaryController < ApplicationController
  def index
    @locations = Location.all.includes(:floor_plans)

    respond_to do |format|

      format.html 
      format.json 

    end
  end

end