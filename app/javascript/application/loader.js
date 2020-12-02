// document.addEventListener('turbolinks:load', function() {
//   // $('[data-toggle="tooltip"]').tooltip();

//   let currentPage = OWSO.Util.getCurrentPage();
//   !!OWSO[currentPage] && OWSO[currentPage].init();
// })

var dev = () => location.hostname == "localhost"

$( document ).on('turbolinks:load', function() {
  var $body = $('body');
  OWSO.Util.closeAlert();
  $body.tooltip({ selector: '[data-toggle="tooltip"]' });
  $body.popover({ selector: '[data-toggle="popover"]' });
  if(!dev()) $('#popup').modal('show');

  let currentPage = OWSO.Util.getCurrentPage();
  !!OWSO[currentPage] && OWSO[currentPage].init();
})
