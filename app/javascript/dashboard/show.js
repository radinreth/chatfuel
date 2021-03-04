import { subCategoriesFeedback } from '../charts/citizen-feedback/feedback_sub_categories_chart'
import { overallFeedback } from '../charts/citizen-feedback/overall_rating_chart'
import formater from '../data/formater'

OWSO.DashboardShow = (() => {

  function init() {
    OWSO.Charts.render();

    attachEventToCollapsedButton()
    attachEventToVariableFilter()
    renderDatetimepicker()
    onChangeProvince()
    onSubmitChooseDictionary()
    onClickChartkickLegend()
    attachEventClickToChartDownloadButton()
    multiSelectDistricts()
    tooltipChart()
    onLoadPopup();
    onChangePeriod()
    loadProvinceSubCategories()
    loadProvinceOverallRating()
  }

  function loadChart(instance, element, data) {
    if( data != undefined ) {
      instance.chartId = element;
      instance.ds = data;
      instance.render();
    }
  }

  function loadProvinceOverallRating() {
    $(".chart_feedback_overall_rating").each(function(_, dom) {
      let id = $(dom).data("id");
      let data = gon.overallRating[id];
      loadChart(overallFeedback, dom.id, data)
    });
  }

  function loadProvinceSubCategories() {
    $(".chart_feedback_by_categories").each(function(_, dom) {
      let id = $(dom).data("id");
      let data = gon.feedbackSubCategories[id];
      loadChart(subCategoriesFeedback, dom.id, data)
    });
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
    $(".modal").on('show.bs.modal', function (event) {
      let btn = $(event.relatedTarget);

      let attrs = {
        provinceId: btn.data("id"),
        callback: btn.data("callback")
      }

      setupModal(attrs);
    });
  }

  function setupModal({ provinceId, callback }) {
    if( callback !== undefined ) {
      OWSO.DashboardShow[callback](provinceId);
    }
  }

  function loadSubCategories(provinceId) {
    let elements = `.chart_feedback_by_sub_category[data-provinceid=${provinceId}]`
    $(elements).each(function(_, dom) {	
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

  return { init, renderDatetimepicker, onChangeProvince, multiSelectDistricts, loadSubCategories }
})();
