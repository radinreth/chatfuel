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
import { overallFeedback } from '../charts/citizen-feedback/overall_rating_chart'
import { trendingFeedback } from '../charts/citizen-feedback/feedback_trend_chart'
import { subCategoriesFeedback } from '../charts/citizen-feedback/feedback_sub_categories_chart'
import formater from '../data/formater'

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
    onLoadPopup();
    onChangePeriod()
  }

  function onChangePeriod() {
    $(document).on("change", ".period-filter", function() {
      let path = $(this).data("resourcepath");
      let url = `/welcomes/q/${path}`;

      let option = {
        url: url,
        target: this,
        extractor: formater[$(this).data("formater")],
        canvasId: $(this).data("canvasid")
      }

      // console.log('option: ', option)
      fetchResultSet(option);
    });
  }

  function fetchResultSet({ url, target, extractor, canvasId }) {
    let period = $(target).val()
    let serializedParams = $('#q').serialize()+`&period=${period}`
    let header = $(target).closest(".card-header");
    let $spin = $(header.next().find(".loading")[0]);

    loading($spin);
    let chart = OWSO.Util.findChartInstance(canvasId)

    $.get(url, serializedParams, function(result) {
      console.log("requested: ....", chart, canvasId)
      chart.data = extractor(result);
      let max = _.max(flatten(chart.data.datasets));
      let suggestedMax = Math.round( max * 1.40 );
      chart.options.scales.yAxes[0].ticks.suggestedMax = suggestedMax;

      chart.update();

      loaded($spin);
    }, "json");
  }

  function flatten(ds) {
    return _.flatten( _.map(ds, d => d.data) )
  }

  function loading(spin) {
    spin.removeClass("d-none");
    spin.next().css({ opacity: 0.3 });
  }

  function loaded(spin) {
    spin.addClass("d-none");
    spin.next().css({ opacity: 1 });
  }

  function onLoadPopup() {
    $("#popup").on('show.bs.modal', function (event) {
      let btn = $(event.relatedTarget);
      let element = btn.data("element");
      let modal = $(this);

      let attrs = {
        size: btn.data("size"),
        title: btn.data("title"),
        body: $(element).html(),
        callback: btn.data("callback")
      }

      setupModal(modal, attrs);
    });
  }

  function setupModal(modal, { size, title, body, callback }) {
    modal.find(".modal-dialog").removeClass("modal-xl").addClass(size);
    modal.find(".modal-title").text(title);
    let modalBody = modal.find(".modal-body");
    if( modalBody.data("state") == "prune" ) {
      modalBody.html(body);
      $(".sub_categories").html("");
      modalBody.data("state", "replaced");
    }

    if( callback !== undefined ) {
      OWSO.DashboardShow[callback]();
    }
  }

  function loadSubCategories() {
    $(".chart_feedback_by_sub_category").each(function(_, dom) {	
      let id = $(dom).data("id");
      let ds = gon.feedbackSubCategories[id];

      if( ds != undefined ) {
        subCategoriesFeedback.chartId = dom.id;
        subCategoriesFeedback.ds = ds;
        subCategoriesFeedback.render();
      }
    });
  }

  function tooltipChart() {
    $(".chart-name")
      .mouseover(function() {
        $(this).next().tooltip("show");
      })
      .mouseleave(function() {
        $(this).next().tooltip("hide");
      });
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
    overallFeedback.render()
    trendingFeedback.render()
    subCategoriesFeedback.render()
  }

  function multiSelectDistricts() {
    $("select").select2({theme: "bootstrap"})
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
      $(".start_date").val(picker.startDate.format('YYYY/MM/DD'))
      $(".end_date").val(picker.endDate.format('YYYY/MM/DD'))
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

  return { init, renderDatetimepicker, onChangeProvince, multiSelectDistricts, loadSubCategories }
})();
