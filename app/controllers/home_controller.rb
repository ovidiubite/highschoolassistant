class HomeController < ApplicationController
  before_action :render_dashboard, only: :home

  def home
  end

  private

  def render_dashboard
    return unless current_user
    redirect_to admin_dashboard_path if current_user.admin?
  end
end
