module Api
  module V1
    class SitesController < ActionController::Base
      skip_before_action :verify_authenticity_token
      before_action :set_site
      rescue_from ActiveRecord::RecordNotFound, with: :site_not_found

      def update
        if @site.valid_token?(bearer_token)
          begin
            @history_log = SyncHistoryLog.create(payload: site_params)
            if @site.update!(site_params.except(:tickets_attributes))
              SyncHistoryJob.perform_later(@history_log.uuid)
            end

            render json: @site, location: @site, status: :ok
          rescue => e
            render json: { message: e.message }, status: :unprocessable_entity
          end
        else
          render json:  { message: "Bad Request",
                          errors: [{
                            resource: "Site",
                            field: "token",
                            message: "Token is not matched"
                          }]
                        }, status: :bad_request
        end
      end

      private
        def set_site
          @site ||= Site.find_by!(code: params[:code])
        end

        def bearer_token
          pattern = /^Bearer /
          header  = request.headers["Authorization"]
          header.gsub(pattern, "") if header && header.match(pattern)
        end

        def site_params
          params.require(:site).permit(:status, :sync_status, tickets_attributes: [:id, :code, :status])
        end

        def site_not_found(exception)
          logger.info "[#{controller_path}] Exception #{exception.class}: #{exception.message}"
          render json:  { message: "Bad Request",
            errors: [{
              resource: "Site",
              field: "code",
              message: "Not found"
            }]
          }, status: :bad_request
        end
    end
  end
end
