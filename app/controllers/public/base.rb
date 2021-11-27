# frozen_string_literal: true

module Public
  class Base < ApplicationController
    layout 'public'
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name profile_image])
    end
  end
end
