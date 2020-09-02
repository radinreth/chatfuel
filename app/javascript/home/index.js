OWSO.HomeIndex = (() => {

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()
    // attachEventClickToExpandedButton()
  }

  function attachEventClickToExpandedButton() {
    $(".btn-collapse").click(function(e) {
      e.preventDefault()
      console.log(this)
    })
  }

  return { init }
})()
