import { totalUserVisitByCategory } from '../charts/total_user_visit_by_category_chart'
import { totalUserFeedback } from '../charts/total_user_feedback_chart'
import { totalUserByGender } from '../charts/total_user_by_gender_chart'

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
  }

  function renderCharts() {
    totalUserVisitByCategory()
    totalUserFeedback()
    totalUserByGender()
  }

  function multiSelectDistricts() {
    $("select:not(.no-select2)").select2({
      theme: "bootstrap",
      dropdownAutoWidth : true,
      width: 'auto'
    })
  }

  function attachEventClickToChartDownloadButton() {
    $(document).on("click", ".chart-dl", async function(e) {
      e.preventDefault();

      let target = $(e.currentTarget);
      let el = $(this).closest(".card-header").next().find(".chart-wrapper")[0];
      let area = el.getBoundingClientRect();

      // related issue on github: https://github.com/niklasvh/html2canvas/issues/882
      let canvas = await html2canvas(el, {
        scrollX: 0,
        scale: 2,
        scrollY: -window.scrollY,
        width: area.width,
        height: area.height
      });

      let name = target.data("name");
      download(canvas, { name });
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

  return { init, renderDatetimepicker, onChangeProvince, multiSelectDistricts, attachEventClickToChartDownloadButton }
})();
