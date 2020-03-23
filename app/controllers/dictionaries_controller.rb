class DictionariesController < ApplicationController
  def index
    @variables = Variable.where.not(name: "done").order(name: :asc)
    authorize @variables
  end

  def new
    @variable = Variable.new
    authorize @variable
  end

  def create
    @variable = Variable.new(variable_params)
    authorize @variable

    if @variable.save
      redirect_to dictionaries_path, status: :moved_permanently, notice: "create success!"
    else
      render :new, status: :unprocessable_entity, alert: "create failed!"
    end
  end

  def update
    @variable = Variable.find(params[:id])
    authorize @variable
    respond_to do |format|
      if @variable.update(variable_params)
        @enabled = @variable.reload.report_enabled
        format.html { redirect_to dictionaries_path, status: :moved_permanently, notice: "Updated successfully!" }
        format.js
      else
        @revert = !variable_params[:report_enabled]
        @enabled = @variable.reload.report_enabled
        format.html { render json: @variable.errors, status: :unprocessable_entity, notice: "Updated fail!" }
        format.js
      end
    end
  end

  def batch_update
    updates = []
    options = { status: :moved_permanently }

    batch_params.each do |item_params|
      updates << update_variable(item_params.permit!)
    end

    if updates.all?(true)
      options[:notice] = "update success"
    # else
      # options[:alert] = "update fail"
    end

    redirect_to dictionaries_path, options
  end

  def destroy
    @variable = Variable.find(params[:id])
    @variable.destroy
  end

  def batch_update
    batch_params.each do |_param|
      id, text = _fetch(_param)
      update_variable(id, text)
    end

    redirect_to dictionaries_path, status: :moved_permanently, notice: "update successful!"
  end

  private
    def _fetch(hash)
      [hash["id"], hash["name"], hash["value"], hash["text"], hash["status"]]
    end

    def update_variable(id, name, value, text, status)
      if id.present?
        variable = Variable.find(id)
        variable.update(value: value, text: text, status: status.to_i) if variable
      else
        BothVariable.create(name: name, value: value, text: text, status: status)
      end
    end

    def batch_params
      params.require(:variable)
    end

    def variable_params
      params.require(:variable).permit(:type, :name, :report_enabled, role_ids: [])
    end
end
