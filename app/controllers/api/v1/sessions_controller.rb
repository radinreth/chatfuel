# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :restrict_access
      before_action :set_variable, only: [:create]
      before_action :set_session, only: [:create]
      before_action :set_step, only: [:create]

      def create
        head :ok
      end

      private
        def set_variable
          @variable = Variable.find_or_create_by(name: params[:name])
          @variable_value = @variable.values.find_or_create_by(raw_value: params[:value])
        end

        def set_step
          @step_value = @session.step_values.find_or_initialize_by(variable: @variable_value.variable)
          @step_value.update!(variable_value: @variable_value)
        end
    end
  end
end
