class HomesController < ApplicationController
  def show
    @pagy, @messages = pagy(Message.all)
    @variables = Variable.pluck(:name).uniq
  end
end
