# frozen_string_literal: true

class ThreadsController < ApplicationController
  before_action :log_console, :set_user

  def index
    render json: resp
  end

  def create
    @activity = @set_user.activities
                         .create_with(value: params[:value])\
                         .find_or_create_by(name: params[:act])
    head :ok
  end

  def continue
    render json: continue_resp
  end

  private

  def resp
    {
      "messages": [
        { "text": 'Hello world' },
        { "text": "your info: #{params['invoice']}-#{params['phone_number']}" }
      ]
    }
  end

  def continue_resp
    {
      "redirect_to_blocks": [@set_user.last_block]
    }
  end

  def log_console
    logger.warn action_name
    logger.info params.inspect
  end

  def set_user
    @set_user ||= User.find_or_create_by(mid: params[:mid]) do |user|
      user.first_name = params[:first_name]
      user.gender = params[:gender]
    end
  end
end
