class AdminController < ApplicationController
  before_action :set_user
  before_action :check_for_file, except: :dashboard
  load_and_authorize_resource :class => self.class

  # admin dashboard
  def dashboard
  end

  def import_highschools
    return redirect_to root_path, alert: "You don't have any county saved into the DB. Please import first the counties!" unless County.any?
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_highschools')
    succes_call
  end

  def import_counties
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_counties')
    succes_call
  end

  def import_admission_results
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_admission_results')
    succes_call
  end

  def import_evaluation_results
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_evaluation_results')
    succes_call
  end

  private

  def succes_call
    redirect_to root_path, notice: "File successfully sent to process."
  end

  def set_user
    @user = current_user
  end

  def check_for_file
    return redirect_to root_path, alert: "Please choose a file" unless params[:file]
  end
end