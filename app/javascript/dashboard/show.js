OWSO.DashboardShow = (() => {
  
  function init() {
    attachEventToCollapsedButton()
    attachEventToVariableFilter()
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

  return { init }
})();
