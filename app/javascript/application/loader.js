// document.addEventListener('turbolinks:load', function() {
//   // $('[data-toggle="tooltip"]').tooltip();

//   let currentPage = OWSO.Util.getCurrentPage();
//   !!OWSO[currentPage] && OWSO[currentPage].init();
// })

var initPopup = function() {
  // Check if user saw the modal
  var key = 'isPopMessageShown',
  isPopMessageShown = localStorage.getItem(key);

  // Show the modal only if new user
  if (!isPopMessageShown) {
    $('#popup').modal('show');
  }

  // If modal is displayed, store that in localStorage
  $('#popup').on('shown.bs.modal', function () {
    localStorage.setItem(key, true);
  })
}

$( document ).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  initPopup();

  let currentPage = OWSO.Util.getCurrentPage();
  !!OWSO[currentPage] && OWSO[currentPage].init();
})
