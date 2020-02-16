class HomesController < ApplicationController
  def show
    @pagy, @messages = pagy(Message.includes(:steps).all)
    @dictionaries = Dictionary.all
  end
end
