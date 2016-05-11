class AdminController < ApplicationController

  # admin dashboard
  def dashboard
  end

  def import_highschools
    ap "==================="
    ap params
    redirect_to root_path, notice: "File successfully uploaded" if Importer.import_highschools(params[:file])
  end
  private

  def set_user
    @user = current_user
  end
end
