# frozen_string_literal: true

module Api
  module V1
    class SyncLogsController < ApplicationController
      def create
        @sync_log = @site.sync_logs.new(sync_log_params)

        if @sync_log.save
          render json: @sync_log
        else
          render json: { message: e.message }, status: :bad_request
        end
      end

      def update
        @sync_log = @site.sync_logs.find(params[:id])

        if @sync_log.update(sync_log_params)
          render json: @sync_log
        else
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      private
        def sync_log_params
          params.require(:sync).permit(:id, :status, payload: [tickets: [:TicketID, :Tel, :DistGis, :ServiceDescription, :Status, :RequestedDate, :ApprovedDate, :DeliveryDate]])
        end
    end
  end
end
