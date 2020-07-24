class HomeController < ApplicationController
  def index
    authorize Message

    @pagy, @messages = pagy(Message.load_by_role(current_user.role))

    render :no_message if @messages.count.zero?
    render :no_role if current_user.role.blank?
  end
end
