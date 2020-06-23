module Api
  module V1
    class SitesController < ActionController::Base
      skip_before_action :verify_authenticity_token
      before_action :set_site
      before_action :verify_token
      rescue_from ActiveRecord::RecordNotFound, with: :site_not_found

      def update
        @history_log = SyncHistoryLog.create(payload: site_params)
        SyncHistoryJob.perform_later(@history_log.uuid)

        render json: @site, location: @site, status: :ok
      rescue => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def check
        @site.update!(sync_status: params[:sync_status])
        render json: { message: @site.id, status: :ok } and return
      rescue => e
        render json: { message: e.message, status: :bad_request } and return
      end

      private
        def verify_token
          if @site.invalid_token?(bearer_token)
            render json: err_json("token", "Not match"), status: :bad_request
          end
        end

        def set_site
          @site ||= Site.find_by!(code: params[:site_code])
        end

        def bearer_token
          pattern = /^Bearer /
          header  = request.headers["Authorization"]
          header.gsub(pattern, "") if header && header.match(pattern)
        end

        def site_params
          params.require(:site).permit(:sync_status, tickets_attributes: [:id, :code, :status])
        end

        def site_not_found(exception)
          logger.info "[#{controller_path}] Exception #{exception.class}: #{exception.message}"
          render json: err_json("code", "Not found"), status: :bad_request
        end

        def err_json(field, message)
          { message: "Bad Request",
            errors: [{
              resource: "Site",
              field: field,
              message: message
            }]
          }
        end
    end
  end
end
