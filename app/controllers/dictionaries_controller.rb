class DictionariesController < ApplicationController
  before_action :set_roles, only: [:index, :edit, :create, :update]
  before_action :set_new_variable, only: [:index, :search]
  before_action :set_variables, only: [:index, :edit]

  def index
    authorize Variable

    @pagy, @variables = pagy(Variable.filter(params).includes(:roles))
  end

  def edit
    gon.feedback_variable = Variable::FEEDBACK
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
    variable.mark_as_most_request!

    head :ok
  end

  def set_user_visit
    variable = Variable.find(variable_id)
    variable.mark_as_user_visit!

    head :ok
  end

  def set_service_accessed
    variable = Variable.find(variable_id)
    variable.mark_as_service_accessed!

    head :ok
  end

  def set_criteria
    variable_value_id = params["variable_value"]["id"]
    variable_value = VariableValue.find(variable_value_id)

    if variable_value.present?
      variable_value.update(criteria: true)
      redirect_to dashboard_path, status: :ok, notice: t("updated.success")
    else
      redirect_to dashboard_path, status: :unprocessable_entity, notice: t("updated.fail")
    end
  end

  def set_variables
    @gender = Variable.gender
    @feedback = Variable.feedback
    @location = Variable.location
    @ticket_tracking = Variable.ticket_tracking
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
      params.require(:variable).permit(:type, :name, :mark_as, role_ids: [], values_attributes: [:id, :raw_value, :mapping_value_en, :mapping_value_km, :hint, :status, :_destroy])
    end
end
