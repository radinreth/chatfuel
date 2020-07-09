OWSO.DashboardShow = (() => {
  
  function init() {
    attachEventToCollapsedButton()
    attachEventToVariableFilter()
    dynamicFormUrl()
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
