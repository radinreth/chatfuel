OWSO.WelcomesIndex = (() => {
  var formQuery, logoContainer, pilotHeader

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()

    formQuery = document.getElementById("form-query")
    logoContainer = document.getElementById("logo-container")
    pilotHeader = document.getElementById("piloting-header")
    window.onscroll = () => { stickOnScroll() }
  }

  function stickOnScroll() {
    if(window.pageYOffset + logoContainer.offsetHeight >= formQuery.offsetTop ) {
      $(formQuery).addClass("fixed-top")
    } 
    
    if(window.pageYOffset < pilotHeader.offsetTop) {
      $(formQuery).removeClass("fixed-top")
    }
  }

  return { init }

})()