import { userVisit } from '../charts/total_user_visit_by_category_chart'
import { userGender } from '../charts/total_user_by_gender_chart'
import { userFeedback } from '../charts/total_user_feedback_chart'

import { ticketTracking } from '../charts/ticket_tracking_chart'
import { overview } from '../charts/overview_chart'
import { feedbackByGender } from '../charts/feedback_by_gender_chart'

import { mostRequest } from '../charts/owso-information-accessed/most_request_service_access_chart'
import { informationAccess } from '../charts/owso-information-accessed/access_info_chart'
import { mainServiceAccess } from '../charts/owso-information-accessed/access_main_service_chart'
import { mostPopularAccess } from '../charts/owso-information-accessed/most_tracked_periodic_chart'
import { ticketTrackingAccess } from '../charts/owso-information-accessed/ticket_tracking_by_genders_chart'

import { genderFeedback } from '../charts/citizen-feedback/gender_feedback_chart'

OWSO.DashboardShow = (() => {

  function init() {
    attachEventToCollapsedButton()
    attachEventToVariableFilter()
    renderDatetimepicker()
    onChangeProvince()
    onSubmitChooseDictionary()
    onClickChartkickLegend()
    attachEventClickToChartDownloadButton()
    multiSelectDistricts()
    renderCharts()
    tooltipChart()
  }

  function tooltipChart() {
    $(document)
      .on("mouseover", ".chart-name", showToolTip )
      .on("mouseleave", ".chart-name", hideToolTip );
  }

  function showToolTip() {
    $(this).next().tooltip("show")
  }

  function hideToolTip() {
    $(this).next().tooltip("hide")
  }

  function renderCharts() {
    OWSO.Util.chartReg();

    userVisit.render({watermark: false});
    userGender.render({watermark: false});
    userFeedback.render({watermark: false})
    ticketTracking.render({watermark: false});
    overview.render({watermark: false});
    feedbackByGender.render({watermark: false});

    // public dashboard
    mostRequest.render()
    informationAccess.render()
    mainServiceAccess.render()
    mostPopularAccess.render()
    ticketTrackingAccess.render()

    genderFeedback.render()
  }

  function multiSelectDistricts() {
    $("select:not(.no-select2)").select2({
      theme: "bootstrap",
      dropdownAutoWidth : true,
      width: 'auto'
    })
  }

  function attachEventClickToChartDownloadButton() {
    $(document).on("click", ".chart-dl", function(e) {
      e.preventDefault();

      let target = $(e.currentTarget);
      let canvasId = $(this).closest(".card-header").next().find(".chart-wrapper canvas").prop("id");

      let chart = OWSO.Util.findChartInstance(canvasId);
      let name = target.data("name");
      download(chart.canvas, { name });
    })
  }

  function download(canvas, options) {
    let link = document.getElementById("link");

    link.setAttribute('download', `${ options['name'] || 'my-chart' }.png`);
    link.setAttribute('target', '_blank');
    link.setAttribute('href', canvas.toDataURL("image/png"));
    link.click();
  }

  function onClickChartkickLegend() {
    $(".chartjs-line-legend").click(function(e) {
      $(this).toggleClass("line-through")

      var index = $(this).data("chart-index");
      var ci = Chartkick.charts['chart-overview'].getChartObject();
      var meta = ci.getDatasetMeta(index);

      meta.hidden = meta.hidden === null ? !ci.data.datasets[index].hidden : null;

      ci.update();
    })
  }

  function renderDatetimepicker() {
    $('.datepicker_date').daterangepicker({
      locale: { format: 'YYYY/MM/DD'},
      cancelLabel: 'Clear',
      alwaysShowCalendars: true,
      showCustomRangeLabel: true,
      ranges: {
        'Today': [moment(), moment()],
        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
     },
     opens: 'left'
    })
    .on('apply.daterangepicker', function(ev, picker) {
      let startDate = picker.startDate.format('YYYY/MM/DD')
      let endDate = picker.endDate.format('YYYY/MM/DD')

      $(".start_date").val(startDate)
      $(".end_date").val(endDate)
      $(".input-daterange").val(`${startDate} - ${endDate}`)
      $('.form').submit();
    })
  }

  function onChangeProvince() {
    $(document).on("change", "#province", function(e) {
      $('#district-hidden').val('');
    })
  }

  function attachEventToCollapsedButton() {
    $(".collapse-item").click(function(e) {
      e.preventDefault()
      $("input[type=radio]").attr("checked", false)

      let checkbox = $(this).prev("input[type=radio]")
      checkbox.attr("checked", true)
    })
  }

  function attachEventToVariableFilter() {
    $(".variable_filter").keyup(function(e) {
      var value = e.target.value.toLowerCase();

      $(this).parent().find(".accordion .card").filter(function() {
        $(this).toggle($(this).find("button").text().trim().toLowerCase().indexOf(value) > -1)
      })
    })
  }

  function onSubmitChooseDictionary() {
    $('.choose-dictionary-form').on('ajax:success', function(e, data, status, xhr) {
      $('.modal').modal('hide');
      window.location.reload();
    })
  }

  return { init, renderDatetimepicker, onChangeProvince, multiSelectDistricts, attachEventClickToChartDownloadButton, tooltipChart }
})();
