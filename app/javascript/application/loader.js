
$( document ).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  OWSO.Util.closeAlert();

  setTimeout(function(e) {
    $("#popup").modal("show");
  }, 5000)

  let currentPage = OWSO.Util.getCurrentPage();
  !!OWSO[currentPage] && OWSO[currentPage].init();
})
