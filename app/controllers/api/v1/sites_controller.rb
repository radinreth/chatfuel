module Api
  module V1
    class SitesController < ActionController::Base
      skip_before_action :verify_authenticity_token

      def update
        render json: { message: bearer_token }, status: :created
      end

      private

      def bearer_token
        pattern = /^Bearer /
        header  = request.headers['Authorization']
        header.gsub(pattern, '') if header && header.match(pattern)
      end
    end
  end
end
