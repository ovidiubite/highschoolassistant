class CountiesController < ApplicationController

  def county_highschools
    highschools = Highschool.joins(:county).select(:id, :name).where(county_id: params[:county_id])
    render json: { highschools: highschools }
  end
end
