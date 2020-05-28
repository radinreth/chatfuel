class TemplatesController < ApplicationController
  before_action :set_template, only: [:edit, :update, :destroy]

  def index
    @templates = Template.all
    authorize @templates
  end

  def new
    @template = Template.new
  end

  def edit
  end

  def update
    if @template.update(template_params)
      redirect_to templates_path, status: :moved_permanently
    end
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to templates_path, status: :moved_permanently
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
      params.require(:template).permit(:content)
    end
end
