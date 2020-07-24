class TemplatesController < ApplicationController
  before_action :set_template, only: [:edit, :update, :destroy]

  def index
    @template = Template.new
    @templates = Template.order(type: :asc)
    authorize @templates
  end

  def new
    @template = Template.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to templates_path, status: :moved_permanently }
        format.js { redirect_to templates_path, status: :moved_permanently }
        format.json { head :no_content }
      else
        format.js
        format.json { render  json: @template.errors,
                              status: :unprocessable_entity }
      end
    end
  end

  def create
    @templates = Template.order(type: :asc)
    @template = Template.new(template_params)
    respond_to do |format|
      if @template.save
        format.html { redirect_to templates_path, status: :moved_permanently, notice: t("created.success") }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity, alert: t("created.fail") }
        format.js
      end
    end
  end

  def destroy
    @template.destroy
    redirect_to templates_path, status: :moved_permanently
  end

  private
    def set_template
      @template ||= Template.find(params[:id])
      authorize(@template) && @template
    end

    def template_params
      params.require(:template).permit(:content, :type, :audio, :image, :status)
    end
end
