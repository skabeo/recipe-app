class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index show]
  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :load_and_authorize_resource

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  def load_and_authorize_resource
    @load_and_authorize_resource ||= ::Ability.new(current_user)
  end
end
