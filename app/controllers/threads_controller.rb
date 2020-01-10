class ThreadsController < ApplicationController
  before_action :log_console

  def index
  end

  def create
  end

  private

    def log_console
      logger.warn action_name
      logger.info params.inspect
      render plain: params.inspect
    end
end

