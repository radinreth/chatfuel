class HomesController < ApplicationController
  def show
    @pagy, @messages = pagy(Message.all)
    @variables = Variable.pluck(:name).uniq
    authorize :menu_item
  end
end
