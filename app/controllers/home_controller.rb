class HomeController < ApplicationController
  def index
    @pagy, @messages = pagy(Message.load_by_role(current_user.role))
    authorize :menu_item

    render :no_message if @messages.count.zero?
    render :no_role if current_user.role.blank?
  end
end
