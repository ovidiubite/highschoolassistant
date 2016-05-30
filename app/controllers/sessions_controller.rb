class SessionsController < Devise::SessionsController
  after_filter :check_for_result, only: :create

  private

  def check_for_result
    return unless params[:result]
    current_user.results << Result.find(params[:result][:id]) if params[:result][:id]
  end
end
