class HighschoolsController < ApplicationController

  def county_highschools
    highschools = Highschool.joins(:county).select(:id, :name).where(county_id: params[:county_id])
    render json: { highschools: highschools }
  end

  def highschool_sections
    sections = Section.joins(:highschool_details).select(:name, :id).where("highschool_details.highschool_id = (?) AND highschool_details.year = (?)", params[:highschool_id], Time.now.year-1)
    render json: { sections: sections }
  end
end
