class SearchController < ApplicationController

  def new
  end

  def calculate_percentage

    highschool_details = HighschoolDetail.where(section_id: params[:section_id], highschool_id: params[:highschool_id]).first

    # dummy data
    predict = Result.predict(params[:evaluation_rate], params[:overall_grade], highschool_details)

    result = Result.create(
      overall_grade: params[:overall_grade],
      evaluation_rate: params[:evaluation_rate],
      date: Date.today,
      percentage: predict,
      highschool_detail_id: highschool_details.id
    )
    current_user.results << result if current_user

    redirect_to show_result_path(result: result, highschool_detail: highschool_details)
  end

  def show_result
    @result = Result.find(params[:result])
    @highschool_detail = HighschoolDetail.find(params[:highschool_detail])
  end
end
