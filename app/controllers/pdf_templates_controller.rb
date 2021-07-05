class PdfTemplatesController < ApplicationController
  before_action :set_pdf_template, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @pdf_templates = pagy(PdfTemplate.order(created_at: :desc))
  end

  def new
    @pdf_template = PdfTemplate.new
  end

  def show
  end

  def create
    @pdf_template = PdfTemplate.new(pdf_template_params)
    if @pdf_template.save
      redirect_to @pdf_template
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pdf_template.update(pdf_template_params)
      redirect_to @pdf_template
    else
      render :edit
    end
  end

  def destroy
    @pdf_template.destroy
    redirect_to action: :index
  end

  private

  def set_pdf_template
    @pdf_template = PdfTemplate.find params[:id]
  end

  def pdf_template_params
    params.require(:pdf_template).permit(:name, :content, :lang_code)
  end
end
