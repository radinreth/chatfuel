class DictionariesController < ApplicationController
  before_action :set_roles, only: [:index, :edit, :create, :update]
  before_action :set_new_variable, only: [:index, :search]

  def index
    authorize Variable

    @pagy, @variables = pagy(Variable.filter(params).includes(:roles))
  end

  def edit
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
        format.js { redirect_to edit_dictionary_path(@variable), status: :moved_permanently, notice: t("created.success") }
      else
        format.html { render :new, status: :unprocessable_entity, alert: t("created.fail") }
        format.js
      end
    end
  end

  def update
    @variable = Variable.find(params[:id])

    authorize @variable
    respond_to do |format|
      if @variable.update(variable_params)
        format.html { redirect_to dictionaries_path, status: :moved_permanently, notice: t("updated.success") }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity, alert: t("updated.fail") }
        format.js
      end
    end
  end

  def set_most_request
    variable = Variable.find(variable_id)
    variable.update(is_most_request: true)

    head :ok
  end

  def set_user_visit
    variable = Variable.find(variable_id)
    variable.update(is_user_visit: true)

    head :ok
  end

  def set_service_accessed
    variable = Variable.find(variable_id)
    variable.update(is_service_accessed: true)

    head :ok
  end

  private
    def variable_id
      params.require(:variable).permit(:id)[:id]
    end

    def set_roles
      @roles = Role.where.not(name: 'system_admin')
    end

    def set_new_variable
      @variable = Variable.new
    end

    def variable_params
      params.require(:variable).permit(:type, :name, :report_enabled, :is_location, :is_ticket_tracking, role_ids: [], values_attributes: [:id, :raw_value, :mapping_value_en, :hint, :status, :_destroy])
    end
end
