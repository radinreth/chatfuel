# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :restrict_access
      def create
        SessionJob.perform_later(params[:name], params[:value], params[:messenger_user_id])
        head :ok
      end
    end
  end
end
