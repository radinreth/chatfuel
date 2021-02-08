# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ::ActionController::Base
      include Localization
      skip_before_action :verify_authenticity_token

      before_action :restrict_access

      private
        def restrict_access
          authenticate_or_request_with_http_token do |token, _options|
            @site = Site.find_with_whitelist(token, request.remote_ip)
            @site.present?
          end
        end
    end
  end
end
