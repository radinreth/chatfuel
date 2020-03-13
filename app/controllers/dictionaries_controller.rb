class DictionariesController < ApplicationController
  def index
    @variables = Variable.order(name: :asc)
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

  private
    def variable_params
      params.require(:variable).permit(:type, :name, :value, :text)
    end
end
