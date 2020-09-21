OWSO.HomeIndex = (() => {

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()
    attachEventClickToExpandedButton()
    attachEventClickToTimeago()
  }

  function attachEventClickToTimeago() {
    $(".timeago").click(function() {
      let fullDatetime = $(this).data("full-datetime")
      $(this).text(fullDatetime)
    })
  }

  function attachEventClickToExpandedButton() {
    $(".btn-collapse").click(function(e) {
      e.preventDefault()
      $(this).toggleClass('fa-rotate-90')
    })
  }

  return { init }
})()
