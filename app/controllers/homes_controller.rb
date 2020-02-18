class HomesController < ApplicationController
  def show
    @pagy, @messages = pagy(Message.includes(:steps))
    @variables = Variable.pluck(:name).uniq
  end
end
