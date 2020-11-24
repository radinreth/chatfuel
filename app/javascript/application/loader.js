// document.addEventListener('turbolinks:load', function() {
//   // $('[data-toggle="tooltip"]').tooltip();

//   let currentPage = OWSO.Util.getCurrentPage();
//   !!OWSO[currentPage] && OWSO[currentPage].init();
// })

$( document ).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  $('#popup').modal('show');

  let currentPage = OWSO.Util.getCurrentPage();
  !!OWSO[currentPage] && OWSO[currentPage].init();
})
