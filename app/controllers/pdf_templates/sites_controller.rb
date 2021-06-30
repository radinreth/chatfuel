class PdfTemplates::SitesController < ApplicationController
  # skip_before_action :authenticate_user_with_guisso!
  include Filterable

  before_action :set_gon

  def show
    @pdf_template = PdfTemplate.find(3).decorate
    @site = Site.find_by(code: params[:id])

    # liquid parse
    # Tilt
    pdf_html = render_to_string(template: "pdf_templates/sites/template.html.haml", layout: "layouts/pdf.html.haml", encoding: "UTF-8")

    respond_to do |format|
      format.html { render template: "pdf_templates/sites/template.html.haml", layout: "layouts/pdf.html.haml" }
      # format.pdf { render_pdf pdf_html }
      format.pdf do
        render pdf: "myfile",
                template: "pdf_templates/sites/template.html.haml",
                layout: "pdf",
                orientation: 'Landscape',
                lowquality: false,
                dpi: '300',
                encoding: 'utf8',
                viewport_size: '1280x1024',
                javascript_delay: 100 # have to set
      end
    end
  end

  private

  def set_gon
    @query = DashboardQuery.new(filter_options)
    gon.push({
      totalUserVisitByCategory: @query.total_users_visit_by_category,
      totalUserFeedback: @query.users_feedback,
    })
  end

  def render_pdf(pdf_html)
    pdf = WickedPdf.new.pdf_from_string(pdf_html, javascript_delay: 15000)
    send_data pdf, filename: 'file.pdf', :type => "application/pdf", disposition: 'inline', javascript_delay: 15000
  end
end
