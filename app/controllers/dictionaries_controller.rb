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
    batch_params.each do |_param|
      id, text = _fetch(_param)
      update_variable(id, text)
    end

    redirect_to dictionaries_path, status: :moved_permanently, notice: "update successful!"
  end

  private
    def _fetch(hash)
      [hash["id"], hash["text"]]
    end

    def update_variable(id, text)
      variable = Variable.find(id)

      variable.update(text: text) if variable
    end

    def batch_params
      params.require(:variable)
    end

    def variable_params
      params.require(:variable).permit(:type, :name, :value, :text)
    end
end
