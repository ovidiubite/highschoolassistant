class HomeController < ApplicationController
  before_action :render_dashboard, only: :home

  def home
  end

  private

  def render_dashboard
    return unless current_user
    return redirect_to admin_dashboard_path if current_user.admin?
    redirect_to user_path current_user if current_user.user?
  end
end
