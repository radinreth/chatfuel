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

  private
    def update_variable(item_params)
      item_id = item_params.delete("variable_id")

      variable = Variable.find(item_id)
      value = variable.values.find_by(raw_value: item_params["raw_value"])

      if value.present?
        value.update(item_params.to_h)
      else
        variable.values.create(item_params)
      end
      # value = variable.values.build(item_params)
      # value.save
      # variable.save

      # item_params["status"] = item_params.delete("status").to_i

      # if item_id.present?
      #   variable = Variable.find(item_id)
      #   variable.update(item_params) if variable
      # else
      #   refined_params = refine(item_params)
      #   variable_id = refined_params.delete("variable_id")
      #   variable = Variable.find(variable_id)
      #   variable.values.create(refined_params)
      # end
    end

    def refine(hash)
      hash.to_h.map { |k, v| [k.sub(/\d+/, ""), v] }.to_h
    end

    def batch_params
      params.require(:variable_value)
    end

    def variable_params
      params.require(:variable).permit(:type, :name, :report_enabled)
    end
end
