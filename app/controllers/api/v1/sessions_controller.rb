# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :restrict_access

      private

      def variable_params
        { name: params[:name], value: params[:value] }
      end

      def chatbot_params
        variable_params.merge(session_id: params[:messenger_user_id])
      end

      def ivr_params
        variable_params.merge(session_id: params[:address], source_id: params[:CallSid])
      end
    end
  end
end
