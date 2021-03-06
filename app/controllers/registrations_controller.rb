class RegistrationsController < Devise::RegistrationsController
  after_filter :check_for_result, only: :create

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def check_for_result
    return unless params[:result]
    current_user.results << Result.find(params[:result][:id]) if params[:result][:id]
  end
end
