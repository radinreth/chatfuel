# frozen_string_literal: true

module Api
  module V1
    class SyncLogsController < ApplicationController
      def create
        @sync_log = @site.sync_logs.new(sync_log_params)

        if @sync_log.save
          render json: @sync_log
        else
          render json: { message: @sync_log.errors }, status: :bad_request
        end
      end

      def update
        @sync_log = @site.sync_logs.find(params[:id])
        if @sync_log.update(sync_log_params)
          render json: @sync_log
        else
          render json: { message: @sync_log.errors }, status: :unprocessable_entity
        end
      end

      private
        def sync_log_params
          params.permit(:id, :status)
                .merge(payload: params.permit(tickets: [:TicketID, :Tel, :DistGis, :ServiceDescription, :Status, :RequestedDate, :ApprovedDate, :DeliveryDate, :Sector]))
        end
    end
  end
end
