module Api
  module V1
    class SocialSharesController < ApplicationController
      def create
        social_share = SocialShare.new(social_share_params)

        if social_share.save
          head :created
        else
          render json: social_share.errors, status: :unprocessable_entity
        end
      end

      private

      def social_share_params
        params.require(:social_share).permit(:site_name)
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, _options|
          token == ENV["TOKEN"]
        end
      end
    end
  end
end
