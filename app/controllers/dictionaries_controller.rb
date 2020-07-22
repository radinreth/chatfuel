class DictionariesController < ApplicationController
  before_action :set_roles, only: [:index, :edit, :create, :update]
  before_action :set_new_variable, only: [:index, :search]

  def index
    authorize Variable

    @pagy, @variables = pagy(Variable.filter(params).except_done.order(created_at: :desc))
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
        format.js
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
    update_variable(most_request_params[0])

    redirect_to dashboard_path
  end

  def set_user_visit
    update_variable(user_visit_params[0])

    redirect_to dashboard_path
  end

  private
    def update_variable(attribute)
      id = attribute.delete(:id)
      variable = Variable.find(id)
      variable.update(attribute)
    end

    def most_request_params
      @most_request_params = params.require(:variable).permit(attributes: [:id, :is_most_request])
      filter_params(@most_request_params, :is_most_request)
    end

    def user_visit_params
      @user_visit_params = params.require(:variable).permit(attributes: [:id, :is_user_visit])
      filter_params(@user_visit_params, :is_user_visit)
    end

    def filter_params(modal_params, key)
      modal_params["attributes"]\
        .reject { |a| a[key].blank? }\
        .map { |a| a.to_h }
    end

    def set_roles
      @roles = Role.all
    end

    def set_new_variable
      @variable = Variable.new
    end

    def variable_params
      params.require(:variable).permit(:type, :name, :report_enabled, :is_location, role_ids: [], values_attributes: [:id, :raw_value, :mapping_value, :status, :_destroy])
    end
end
