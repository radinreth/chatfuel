OWSO.DashboardShow = (() => {

  function init() {
    attachEventToCollapsedButton()
    attachEventToVariableFilter()
    dynamicFormUrl()
    renderDatetimepicker()
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
      $('.form').submit();
    })
  }

  function attachEventToCollapsedButton() {
    $(".collapse-most-request").click(function(e) {
      e.preventDefault()
      $("input[type=radio]").attr("checked", false)

      let checkbox = $(this).prev("input[type=radio]")
      checkbox.attr("checked", true)
    })
  }

  function attachEventToVariableFilter() {
    $("#variable_filter").keyup(function(e) {
      var value = e.target.value.toLowerCase();

      $(".accordion .card").filter(function() {
        $(this).toggle($(this).find("button").text().trim().toLowerCase().indexOf(value) > -1)
      })
    })
  }

  function dynamicFormUrl() {
    $('#mostRequest').on('show.bs.modal', function (event) {
      var button = $(event.relatedTarget)
      var id = button.data("id")
      var name = button.data("name")
      var url = button.data("url")

      var modal = $(this)
      $("input[type=radio]").attr("checked", false)
      modal.find("form").attr("action", url)
      modal.find("input[type=radio]").attr("name", name)
      modal.find(`input[type=radio][name='${name}'][value='${id}']`).attr("checked", true)
    })
  }

  return { init }
})();
