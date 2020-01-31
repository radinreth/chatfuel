class HomesController < ApplicationController
  def show
    @messages = Message.all
  end
end
