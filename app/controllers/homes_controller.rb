class HomesController < ApplicationController
  def show
    @pagy, @messages = pagy(Message.all)
    authorize :menu_item

    render :no_message if @messages.count.zero?
    render :no_role if current_user.role.blank?
  end
end
