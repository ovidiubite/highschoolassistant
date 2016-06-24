class HomeController < ApplicationController
  before_action :render_dashboard, only: :home

  def home
  end

  def methodology
    pdf_filename = File.join(Rails.root, "public/files/brosura_2016.pdf")
    send_file(pdf_filename, :filename => "brosura_2016.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def about
  end

  private

  def render_dashboard
    return unless current_user
    redirect_to admin_dashboard_path if current_user.admin?
  end
end
