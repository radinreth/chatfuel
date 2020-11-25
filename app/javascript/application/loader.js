// document.addEventListener('turbolinks:load', function() {
//   // $('[data-toggle="tooltip"]').tooltip();

//   let currentPage = OWSO.Util.getCurrentPage();
//   !!OWSO[currentPage] && OWSO[currentPage].init();
// })

var dev = () => location.hostname == "localhost"

$( document ).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  if(!dev()) $('#popup').modal('show');

  let currentPage = OWSO.Util.getCurrentPage();
  !!OWSO[currentPage] && OWSO[currentPage].init();
})
