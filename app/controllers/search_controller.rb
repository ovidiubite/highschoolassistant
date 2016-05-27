class SearchController < ApplicationController

  def calculate_percentage

    highschool_details = HighschoolDetail.where(section_id: params[:section_id], highschool_id: params[:highschool_id]).first

    # dummy data
    percentage = '68.64'

    Result.create(
      overall_grade: params[:overall_grade],
      evaluation_rate: params[:evaluation_rate],
      graduation_rate: params[:graduation_rate],
      date: Date.today,
      percentage: percentage,
      highschool_details_id: highschool_details.id,
      user_id: current_user.present? ? current_user.id : nil
    )
  end
end
