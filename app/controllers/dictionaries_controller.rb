class DictionariesController < ApplicationController
  def index
    @pagy, @variables = pagy(Variable.except_done)
    @variable = Variable.new
    authorize @variables
  end

  def new
    @variable = Variable.new
    @variable.values.build
    authorize @variable
  end

  def edit
    @roles = Role.all
    @variable = Variable.find(params[:id])
    @variable.values.build
    authorize @variable
  end

  def create
    @variable = Variable.new(variable_params)
    authorize @variable

    respond_to do |format|
      if @variable.save
        format.html { redirect_to dictionaries_path, status: :moved_permanently, notice: t("created.success") }
        format.json { render json: @variable, status: :created, location: @variable }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity, alert: t("created.fail") }
        format.json { render json: @variable.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    @variable = Variable.find(params[:id])
    @roles = Role.all

    authorize @variable
    respond_to do |format|
      if @variable.update(variable_nested_params)
        format.html { redirect_to dictionaries_path, status: :moved_permanently, notice: t("updated.success") }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity, alert: t("updated.fail") }
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
      options[:notice] = t("updated.success")
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

  def batch_update
    batch_params.each do |_param|
      id, text = _fetch(_param)
      update_variable(id, text)
    end

    redirect_to dictionaries_path, status: :moved_permanently, notice: "update successful!"
  end

  private
    def update_variable(item_params)
      item_id = item_params.delete("id")
      item_params["status"] = item_params.delete("status").to_i

      if item_id.present?
        variable = Variable.find(item_id)
        variable.update(item_params) if variable
      else
        Variable.create(item_params)
      end
    end

    def batch_params
      params.require(:variable)
    end

    def variable_params
      params.require(:variable).permit(:type, :name)
    end

    def variable_nested_params
      params.require(:variable).permit(:report_enabled, role_ids: [], values_attributes: [:id, :raw_value, :mapping_value, :status, :_destroy])
    end
end
