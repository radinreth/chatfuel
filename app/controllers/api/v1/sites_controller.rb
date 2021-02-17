module Api
  module V1
    class SitesController < ApplicationController
      include Previewable

      def update
        SyncHistoryLog.create(payload: ticket_params, site_id: @site.id)

        head :ok
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
        def ticket_params
          params.permit(tickets: [:TicketID, :Sector, :Tel, :DistGis, :ServiceDescription, :Status, :RequestedDate, :ApprovedDate, :DeliveryDate])
        end
    end
  end
end
