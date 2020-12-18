class Public::Base < ApplicationController
        layout 'public'
        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :profile_image])
        end
end
