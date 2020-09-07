OWSO.HomeIndex = (() => {

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()
    attachEventClickToExpandedButton()
  }

  function attachEventClickToExpandedButton() {
    $(".btn-collapse").click(function(e) {
      e.preventDefault()
      $(this).toggleClass('fa-rotate-90')
    })
  }

  return { init }
})()
