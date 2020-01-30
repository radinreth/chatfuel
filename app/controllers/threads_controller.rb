# frozen_string_literal: true

class ThreadsController < ApplicationController
  before_action :log_console
  before_action :set_lead, only: [:create]
  skip_before_action :verify_authenticity_token

  def index
    @leads = Lead.all
  end

  def show
    @lead = Lead.find params[:id]
  end

  def create
    @activity = @set_lead.activities
                         .create_with(value: params[:value])\
                         .find_or_create_by(name: params[:act])
    if params[:act] === 'SET_DONE'
      render json: resp
    else
      head :ok
    end
  end

  def continue
    render json: continue_to_chat_block
  end

  private

  def resp
    {
      "messages": [
        { "text": 'Your result is:' },
        { "text": "your info: #{params['invoice']}-#{params['phone_number']}" }
      ]
    }
  end

  def continue_to_chat_block
    {
      "redirect_to_blocks": [@set_lead.last_block]
    }
  end

  def log_console
    logger.warn action_name
    logger.info params.inspect
  end

  def set_lead
    @set_lead ||= Lead.find_or_create_by(mid: params[:mid]) do |lead|
      lead.first_name = params[:first_name]
      lead.gender = params[:gender]
    end
  end
end
