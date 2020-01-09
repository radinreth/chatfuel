class ThreadsController < ApplicationController
  def index
    render plain: params.inspect
  end
end

