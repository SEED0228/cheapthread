# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when EndUser
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_admin_session_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name profile_image])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name])
  end
end
