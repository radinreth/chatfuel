class ThreadsController < ApplicationController
  def index
    logger.info params.inspect
    render plain: params.inspect
  end
end

