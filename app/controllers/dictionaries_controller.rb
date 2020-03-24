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
    if @variable.update(variable_params)
      redirect_to dictionaries_path, status: :moved_permanently, notice: "Updated successfully!"
    else
      render json: @variable.errors, status: :unprocessable_entity, notice: "Updated fail!"
    end
  end

  def batch_update
    batch_params.each do |item_params|
      update_variable(item_param)
    end

    redirect_to dictionaries_path, status: :moved_permanently, notice: "update successful!"
  end

  def destroy
    @variable = Variable.find(params[:id])
    @variable.destroy
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
      params.require(:variable).permit(:type, :name, :value, :text, :status)
    end
end
