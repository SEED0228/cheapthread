# frozen_string_literal: true

module Public
  class Base < ApplicationController
    layout 'public'
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name profile_image])
    end

    def set_nanj
      ip = request.remote_ip
      @nanj = Nanj.find_by(ip_address: ip)
      if @nanj.nil?
        @nanj = Nanj.create!(ip_address: ip, random_number: SecureRandom.hex(8))
      elsif @nanj.updated_at.to_date < Time.zone.today
        @nanj.update_random_number
      end
    end
  end
end
