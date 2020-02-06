class HomesController < ApplicationController
  def show
    @messages = Message.includes(:steps).all
  end
end
