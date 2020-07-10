module Api
  module V1
    class SitesController < ApplicationController
      def update
        @history_log = SyncHistoryLog.create(payload: site_params)
        SyncHistoryJob.perform_later(@site.id, @history_log.uuid)

        render json: @site, location: @site, status: :ok
      rescue => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def check
        @site.update!(sync_status: params[:sync_status])
        @site.sync_logs.create(status: params[:sync_status])

        render json: { message: @site.id, status: :ok }
      rescue => e
        render json: { message: e.message, status: :bad_request }
      end

      private
        def site_params
          params.permit(tickets: [:code, :status])
        end
    end
  end
end
