# frozen_string_literal: true

module Bots::Sessions
  class ChatbotController < ::Bots::SessionsController
    private
      def set_session
        @session = Session.create_with(platform_name: "Messenger").find_or_create_by(address: params[:messenger_user_id])
      end
  end
end
