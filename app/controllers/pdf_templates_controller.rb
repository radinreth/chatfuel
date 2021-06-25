class PdfTemplatesController < ApplicationController
  def index
    @pdf_templates = PdfTemplate.all
  end

  def new
    @pdf_template = PdfTemplate.new
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
