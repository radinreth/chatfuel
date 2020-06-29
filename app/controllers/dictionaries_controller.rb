class DictionariesController < ApplicationController
  before_action :set_roles, only: [:index, :edit, :create, :update]
  before_action :set_new_variable, only: [:index, :search]

  def index
    @variables = Variable.except_done.order(created_at: :desc)
    
    if params[:q].present?
      @variables = @variables.where("name LIKE ?", "%#{params[:q]}%")
    end

    @pagy, @variables = pagy(@variables)
    authorize @variables
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

  private
    def set_roles
      @roles = Role.all
    end

    def set_new_variable
      @variable = Variable.new
    end

    def variable_params
      params.require(:variable).permit(:type, :name, :report_enabled, role_ids: [], values_attributes: [:id, :raw_value, :mapping_value, :status, :_destroy])
    end
end
