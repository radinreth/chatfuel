class HomesController < ApplicationController
  def show
    @messages = Message.includes(:steps).all
    @variables = ["f1", "f11", "f111", "f112", "f113", "f121", "f122", "f131"]
  end
end
