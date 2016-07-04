class Admin::DashboardController < ApplicationController
  before_action :set_user
  before_action :check_for_file, only: [:import_highschools, :import_counties, :import_admission_results, :import_evaluation_results]
  authorize_resource :class => false

  # admin dashboard
  def dashboard
  end

  def users_index
    @users = User.where.not(role_id: Role.find_by(name: 'admin').id)
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
    return redirect_to root_path, alert: "The data from #{params[:year]} was already processed." if HighschoolDetail.where(year: params[:year]).any?
    Resque.enqueue(HtmlDataFetchWorker, 'fetch_highschools', params[:year])
    redirect_to root_path, notice: 'Fetching data from www.admitere.edu.ro in progress.'
  end

  def fetch_evaluation_results
    return redirect_to root_path, alert: "The data from #{params[:year]} was already processed." if EvaluationResult.where(year: params[:year]).any?
    Resque.enqueue(HtmlDataFetchWorker, 'fetch_evaluation_results', params[:year])
    redirect_to root_path, notice: 'Fetching data from www.evaluare.edu.ro in progress.'
  end

  def fetch_admission_results
    return redirect_to root_path, alert: "The data from #{params[:year]} was already processed." if AdmissionResult.where(year: params[:year]).any?
    Resque.enqueue(HtmlDataFetchWorker, 'fetch_admission_results', params[:year])
    redirect_to root_path, notice: 'Fetching data from www.admitere.edu.ro in progress.'
  end

  def highschools
    @highschools = Highschool.all.order('name DESC')
  end

  def highschool_details
    @highschool = HighschoolDetail.where(highschool_id: params[:id])
  end

  def evaluation_graph
    @evaluation_grade = AdmissionResult.select('id, evaluation_rate').where(county_id: County.find_by(alias: 'TM'), year: 2015).order('evaluation_rate DESC').collect{ |x| x.evaluation_rate.to_f }
    @evaluation_grade2014 = AdmissionResult.select('id, evaluation_rate').where(county_id: County.find_by(alias: 'CJ'), year: 2015).order('evaluation_rate DESC').collect{ |x| x.evaluation_rate.to_f }
    @graudation_grade = AdmissionResult.select('id, graduation_rate').where(county_id: County.find_by(alias: 'TM'), year: 2015).order('graduation_rate DESC').map{ |x| x.graduation_rate.to_f }
    @admission_grade = AdmissionResult.select('id, admission_rate').where(county_id: County.find_by(alias: 'TM'), year: 2015).order('admission_rate DESC').map{ |x| x.admission_rate.to_f }
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
