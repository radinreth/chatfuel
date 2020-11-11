(function ($) {
  $.fn.replaceClass = function (pFromClass, pToClass) {
    return this.removeClass(pFromClass).addClass(pToClass);
  };
}(jQuery));

OWSO.WelcomesIndex = (() => {
  var logoContainer, pilotHeader

  let items = [
    { element: ".q_province", fromClass: "col-lg-3", toClass: "col-lg-4" },
    { element: ".q_district", fromClass: "col-lg-3", toClass: "col-lg-4" },
    { element: ".q_time_period", fromClass: "col-lg-2", toClass: "col-lg-3" }
  ]

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()
    OWSO.DashboardShow.multiSelectDistricts()

    onWindowScroll()
    onChangeDistrict()
  }

  function onWindowScroll() {
    logoContainer = $("#logo-container")
    pilotHeader = $("#piloting-header")
    window.onscroll = () => { stickOnScroll() }
  }

  function onChangeDistrict() {
    $(document).on("change", "#district", function(e) {
      if( e.target.disabled ) {
        $("#time_period, #btn-search").prop("disabled", true)
      } else {
        $("#time_period, #btn-search").prop("disabled", false)
      }
    })
  }

  function stickOnScroll() {
    if(window.pageYOffset >= (logoContainer.outerHeight() + pilotHeader.offset().top) ) {
      $(".logo-inline").show()
      decreaseFormControlWidth()
    } 
    
    if(window.pageYOffset < pilotHeader.offset().top) {
      $(".logo-inline").hide()
      increaseFormControlWidth()
    }
  }

  function decreaseFormControlWidth() {
    $.each(items, function(_, item) {
      var { element, fromClass, toClass } = item
      $(element).replaceClass(toClass, fromClass)
    })
  }

  function increaseFormControlWidth() {
    $.each(items, function(_, item) {
      var { element, fromClass, toClass } = item
      $(element).replaceClass(fromClass, toClass)
    })
  }

  return { init }

})()