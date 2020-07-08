OWSO.DashboardShow = (() => {
  
  function init() {
    attachEventToCollapsedButton()
  }

  function attachEventToCollapsedButton() {
    $(".collapse-most-request").click(function(e) {
      e.preventDefault()
      $("input[type=radio]").attr("checked", false)

      let checkbox = $(this).children("input[type=radio]")
      checkbox.attr("checked", true)
    })
  }

  return { init }
})();
