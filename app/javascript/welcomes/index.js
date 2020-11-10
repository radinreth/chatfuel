OWSO.WelcomesIndex = (() => {
  var formQuery, logoContainer, pilotHeader

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()
    OWSO.DashboardShow.multiSelectDistricts()
    onChangeDistrict()

    formQuery = document.getElementById("form-query")
    logoContainer = document.getElementById("logo-container")
    pilotHeader = document.getElementById("piloting-header")
    window.onscroll = () => { stickOnScroll() }
  }

  function onChangeDistrict() {
    $(document).on("change", "#district", function(e) {
      if( e.target.disabled ) {
        $("#time_period").prop("disabled", true)
        $("#btn-search").prop("disabled", true)
      } else {
        $("#time_period").prop("disabled", false)
        $("#btn-search").prop("disabled", false)
      }
    })
  }

  function stickOnScroll() {
    if(window.pageYOffset + logoContainer.offsetHeight >= formQuery.offsetTop ) {
      $(formQuery).addClass("fixed-top shadow")
    } 
    
    if(window.pageYOffset < pilotHeader.offsetTop) {
      $(formQuery).removeClass("fixed-top shadow")
    }
  }

  return { init }

})()