class HomeController < ApplicationController
  def index
    @pagy, @messages = pagy(Message.joins(steps: { value: :variable }).where("variables.name IN (?)", current_user.role.variables.pluck(:name)))
    authorize :menu_item

    render :no_message if @messages.count.zero?
    render :no_role if current_user.role.blank?
  end
end
