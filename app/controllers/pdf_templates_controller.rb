class PdfTemplatesController < ApplicationController
  def index
    @pdf_templates = PdfTemplate.all
  end

  def new
    @pdf_template = PdfTemplate.new
  end

  def show
    @pdf_template = PdfTemplate.find params[:id]
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
  end

  def destroy
  end

  private

  def pdf_template_params
    params.require(:pdf_template).permit(:name, :content, :lang_code)
  end
end
