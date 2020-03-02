class DictionariesController < ApplicationController
  def index
    @variables = Variable.order(name: :asc)
  end

  def update
    @variable = Variable.find(params[:id])

    if @variable.update(variable_params)
      redirect_to dictionaries_path, status: :moved_permanently, notice: 'Updated successfully!'
    else
      render json: @variable.errors, status: :unprocessable_entity, notice: 'Updated fail!'
    end
  end

  private

  def variable_params
    params.require(:variable).permit(:text)
  end
end
