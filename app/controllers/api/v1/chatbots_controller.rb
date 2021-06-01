# frozen_string_literal: true

module Api
  module V1
    class ChatbotsController < SessionsController
      def mark_as_completed
        SessionMarkAsCompleteJob.perform_later(params[:messenger_user_id])
        head :ok
      end

      def create
        SessionJob.perform_later(params[:name], params[:value], params[:messenger_user_id])
        head :ok
      end
    end
  end
end
