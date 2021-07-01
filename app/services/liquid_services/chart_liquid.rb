require 'haml'

module LiquidServices
  class ChartLiquid
    def to_h
      { 'summary' => summary_html,
        'feedback_sub_categories' => feedback_sub_categories_html,
        'service_popularity' => most_popular_service_html }
    end

    private

    def summary_html
      summary_html = <<~HTML
      .container-fluid
        .row.d-table-row
          .col.w-50.d-table-cell
            .card.shadow.mb-4{ role: "figure" }
              .card-header.position-relative
                .d-flex.flex-row.align-items-center.justify-content-between
                  .h5.m-0.font-weight-bold.d-flex.justify-content-center.align-items-center
                    %span.chart-name.text-primary.d-inline-block.mr-1.chart-head.text-capitalize
                      = I18n.t("dashboard.total_user_visit")
              .card-body
                .chart-wrapper.pt-4.d-flex.justify-content-around.align-items-center.position-relative{ style: "width: 483px; height: 250px"}
                  %canvas#chart_total_user_visit
          .col.w-50.d-table-cell
            .card.shadow.mb-4{ role: "figure" }
              .card-header.position-relative
                .d-flex.flex-row.align-items-center.justify-content-between
                  .h5.m-0.font-weight-bold.d-flex.justify-content-center.align-items-center
                    %span.chart-name.text-primary.d-inline-block.mr-1.chart-head.text-capitalize
                      = I18n.t("dashboard.total_user_feedback")
              .card-body
                .chart-wrapper.pt-4.d-flex.justify-content-around.align-items-center.position-relative{ style: "width: 483px; height: 250px"}
                  %canvas#total_user_feedback
      HTML

      template = Tilt::HamlTemplate.new { summary_html }
      template.render
    end

    def feedback_sub_categories_html
      html = <<~HTML
      .container-fluid
        .row.d-table-row
          .col.w-100.d-table-cell
            .card.shadow.mb-4{ role: "figure" }
              .card-header.position-relative
                .d-flex.flex-row.align-items-center.justify-content-between
                  .h5.m-0.font-weight-bold.d-flex.justify-content-center.align-items-center
                    %span.chart-name.text-primary.d-inline-block.mr-1.chart-head.text-capitalize
                      = I18n.t("dashboard.total_user_visit")
              .card-body
                .chart-wrapper.pt-4.d-flex.justify-content-around.align-items-center.position-relative{ style: "width: 483px; height: 250px"}
                  %canvas#chart_feedback_by_sub_category
      HTML

      template = Tilt::HamlTemplate.new { html }
      template.render
    end

    def most_popular_service_html
      html = <<~HTML
      .container-fluid
        .row.d-table-row
          .col.w-100.d-table-cell
            .card.shadow.mb-4{ role: "figure" }
              .card-header.position-relative
                .d-flex.flex-row.align-items-center.justify-content-between
                  .h5.m-0.font-weight-bold.d-flex.justify-content-center.align-items-center
                    %span.chart-name.text-primary.d-inline-block.mr-1.chart-head.text-capitalize
                      = I18n.t("welcomes.number_access_by_main_services")
              .card-body
                .chart-wrapper.pt-4.d-flex.justify-content-around.align-items-center.position-relative{ style: "width: 483px; height: 250px"}
                  %canvas#chart_number_access_by_main_services
      HTML

      template = Tilt::HamlTemplate.new { html }
      template.render
    end
  end
end
