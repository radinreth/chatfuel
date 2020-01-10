class ThreadsController < ApplicationController
  before_action :log_console

  def index
    render json: resp
  end

  def create
  end

  private
    def resp
      {
        "messages": [
          {"text": "Hello world"},
          {"text": "your info: #{params['invoice']}-#{params['phone_number']}"}
        ]
      }
    end

    def log_console
      logger.warn action_name
      logger.info params.inspect
    end
end

