# frozen_string_literal: true

module Bots::Sessions
  class ChatbotController < ::Bots::SessionsController
    def mark_as_completed
      @session&.completed!
    end

    private
      def set_session
        @session = Session.create_or_return('Messenger', params[:messenger_user_id])
      end
  end
end
