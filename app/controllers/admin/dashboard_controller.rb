class Admin::DashboardController < ApplicationController
  before_action :set_user
  before_action :check_for_file, only: [:import_highschools, :import_counties, :import_admission_results, :import_evaluation_results]
  authorize_resource :class => false

  # admin dashboard
  def dashboard
  end

  def import_admission_results
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_admission_results')
    succes_call
  end

  def import_evaluation_results
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_evaluation_results')
    succes_call
  end

  def fetch_highschool_data
    return redirect_to root_path, warning: "The data from #{params[:year]} was already processed." if HighschoolDetail.where(year: params[:year]).any?
    Resque.enqueue(HtmlDataFetchWorker, params[:year])
    redirect_to root_path, notice: 'Fetching data from www.admitere.edu.ro in progress.'
  end

  def highschools
    # @highschools = Highschool.all.order(county_id: 'asc')

    @highschools = Highschool.order(county_id: 'asc').paginate(:page => params[:page], :per_page => 20)

    # or, use an explicit "per page" limit:

  end

  def highschool_details
    @highschool = HighschoolDetail.where(highschool_id: params[:id])
  end

  private

  def succes_call
    redirect_to root_path, notice: 'File successfully sent to process.'
  end

  def set_user
    @user = current_user
  end

  def check_for_file
    return redirect_to root_path, alert: 'Please choose a file' unless params[:file]
  end
end
