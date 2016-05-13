class AdminController < ApplicationController
  before_action :set_user
  load_and_authorize_resource :class => self.class

  # admin dashboard
  def dashboard
  end

  def import_highschools
    return redirect_to root_path, warning: "You don't have any county the DB. Please import first the counties!"
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_highschools')
    redirect_to root_path, notice: "File successfully sent to process"
  end

  def import_counties
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_counties')
    redirect_to root_path, notice: "File successfully sent to process"
  end

  def import_admission_results
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_admission_results')
    redirect_to root_path, notice: "File successfully sent to process"
  end

  def import_evaluation_results
    Resque.enqueue(CsvImporterWorker, params[:file].path, 'import_evaluation_results')
    redirect_to root_path, notice: "File successfully sent to process"
  end

  private

  def set_user
    @user = current_user
  end
end
