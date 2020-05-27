class ValuesController < ApplicationController
  def destroy
    @variable = Variable.find(params[:dictionary_id])
    @value = @variable.values.find(params[:id])
    @value.destroy
    redirect_to dictionaries_path
  end
end
