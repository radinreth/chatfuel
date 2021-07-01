require 'haml'

module LiquidServices
  class ChartLiquid
    def to_h
      { 'summary' => html }
    end

    private

    def html
      html = <<~HTML
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

      template = Tilt::HamlTemplate.new { html }
      template.render
    end
  end
end
