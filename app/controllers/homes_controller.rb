class HomesController < ApplicationController
  def show
    @messages = Message.includes(:steps).all
    @dictionaries = Dictionary.all
  end
end
