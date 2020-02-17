class HomesController < ApplicationController
  def show
    @pagy, @messages = pagy(Message.includes(:steps).order(updated_at: 'desc').all)
    @dictionaries = Dictionary.all
  end
end
