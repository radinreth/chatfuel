class TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end

  def new
    @template = Template.new
  end

  def edit
    @template = Template.find(params[:id])
  end

  def update
    @template = Template.find(params[:id])

    if @template.update(template_params)
      redirect_to templates_path
    end
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to templates_path
    end
  end

  private
    def template_params
      params.require(:template).permit(:content)
    end
end
