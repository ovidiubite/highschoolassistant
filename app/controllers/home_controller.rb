class HomeController < ApplicationController

  def render_dashboard
    return redirect_to users_path unless current_user
    return redirect_to admin_dashboard_path if current_user.admin?
  end
end
