class HomeController < ApplicationController
  def index
    authorize Message

    if current_user.system_admin?
      @variables = Variable.all
      @collection = Message.includes(:step_values)
    else
      @variables = current_user.role.variables
      @collection = Message.where(id: StepValue.select('message_id').where('variable_id in (?)', @variables.ids)).includes(:step_values)
    end

    @pagy, @messages = pagy(@collection)

    render :no_message if @messages.count.zero?
    render :no_role if current_user.role.blank?
  end
end
