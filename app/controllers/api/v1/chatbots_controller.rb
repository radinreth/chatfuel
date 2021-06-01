# frozen_string_literal: true

module Api
  module V1
    class ChatbotsController < SessionsController
      def mark_as_completed
        Session::Chatbot::MarkStatusJob.perform_later(params[:messenger_user_id])
        head :ok
      end

      def create
        Session::ChatbotJob.perform_later(chatbot_params)
        head :ok
      end
    end
  end
end
