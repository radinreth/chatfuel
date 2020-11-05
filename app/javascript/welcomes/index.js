OWSO.WelcomesIndex = (() => {
  var formQuery, logo, pilotHeader

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()

    formQuery = document.getElementById("form-query")
    logo = document.getElementById("logo")
    pilotHeader = document.getElementById("piloting-header")
    window.onscroll = () => { stickOnScroll() }
  }

  function stickOnScroll() {
    if(window.pageYOffset + logo.offsetHeight >= formQuery.offsetTop ) {
      $(formQuery).addClass("fixed-top")
    } 
    
    if(window.pageYOffset < pilotHeader.offsetTop) {
      $(formQuery).removeClass("fixed-top")
    }
  }

  return { init }

})()