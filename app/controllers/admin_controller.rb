class AdminController < ApplicationController

  # admin dashboard
  def dashboard
  end

  def import_highschools
    Resque.enqueue(CsvImporterWorker, params[:file].path)

    redirect_to root_path, notice: "File successfully uploaded"
  end
  private

  def set_user
    @user = current_user
  end
end
