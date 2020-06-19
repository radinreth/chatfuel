module Api
  module V1
    class SitesController < ActionController::Base
      skip_before_action :verify_authenticity_token
      before_action :set_site

      def update
        if  @site && @site.valid_token?(bearer_token)
          
          begin
            @site.update(sync_status: params[:sync_status])
            render json: @site, location: @site, status: :ok
          rescue => e
            render json: { message: e.message }, status: :unprocessable_entity
          end
        else
          render json:  { message: "Bad Request", 
                          errors: [{
                            resource: "Site",
                            field: "token",
                            message: "Not found or Token is not matched"
                          }]
                        }, status: :bad_request
        end
      end

      private

      def set_site
        @site ||= Site.find_by(code: params[:code])
      end

      def bearer_token
        pattern = /^Bearer /
        header  = request.headers['Authorization']
        header.gsub(pattern, '') if header && header.match(pattern)
      end
    end
  end
end
