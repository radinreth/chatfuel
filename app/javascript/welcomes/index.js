OWSO.WelcomesIndex = (() => {
  var header
  var logo
  var sticky

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()

    header = document.getElementById("header")
    logo = document.getElementById("logo")
    sticky = header.offsetTop
    window.onscroll = () => { stickOnScroll() }
  }

  function stickOnScroll() {
    if(window.pageYOffset + logo.offsetHeight > sticky ) {
      header.classList.add("fixed-top")
    } else {
      header.classList.remove("fixed-top")
    }
  }

  return { init }

})()