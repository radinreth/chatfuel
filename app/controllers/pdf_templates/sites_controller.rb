class PdfTemplates::SitesController < ApplicationController
  include Filterable

  before_action :default_start_date
  before_action :set_daterange
  before_action :set_site
  before_action :set_gon

  def show
    @pdf_template = PdfTemplate.find(params[:pdf_template_id]).decorate

    respond_to do |format|
      format.html { render template: 'pdf_templates/sites/template', layout: 'pdf' }
      format.pdf do
        render pdf: pdf_name,
                template: 'pdf_templates/sites/template.html',
                layout: 'pdf',
                orientation: 'Portrait',
                lowquality: false,
                dpi: 300,
                encoding: 'utf8',
                page_size: 'A4',
                header: { right: '[page] of [topage]' },
                # Delay for chartjs to execute before render pdf
                javascript_delay: 100
      end
    end
  end

  def set_site
    @site = Site.find_by(code: params[:district_code])
  end

  private

  def pdf_name
    "DO-report-#{DateTime.current.strftime("%Y%m%d%H%M%S")}"
  end

  def default_start_date
    Setting.dashboard_start_date.strftime('%Y/%m/%d')
  end

  def set_gon
    @query = DashboardQuery.new(filter_options)
    gon.push({
      totalUserVisitByCategory: @query.total_users_visit_by_category,
      totalUserFeedback: @query.users_feedback,
      feedbackSubCategories: @query.feedback_sub_categories[@site.code],
      accessMainService: @query.access_main_service
    })
  end
end
