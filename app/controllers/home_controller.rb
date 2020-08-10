class HomeController < ApplicationController
  before_action :set_daterange

  def index
    authorize Message
    collection = Message.period(@start_date, @end_date)

    if current_user.system_admin?
      @variables = Variable.all
      @collection = collection.includes(:step_values)
    else
      @variables = current_user.role.variables
      @collection = collection.where(id: StepValue.select('message_id').where('variable_id in (?)', @variables.ids)).includes(:step_values)
    end

    @pagy, @messages = pagy(@collection)
    respond_to do |format|
      format.html
      format.csv { send_data Message.download(@messages, @variables) }
    end

    render :no_message if @messages.count.zero?
    render :no_role if current_user.role.blank?
  end
end
