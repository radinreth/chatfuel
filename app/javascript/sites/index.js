OWSO.SitesIndex = (() => {
  return {
    init
  }

  function init() {
    onCollapseShow();
    onCollapseHide();
  }

  function onCollapseShow() {
    $(".accordion-body").on("show.bs.collapse", function(){
      $(this).prev().find('.btn-toggle').html('<i class="fas fa-chevron-up"></i>');
    });
  }

  function onCollapseHide() {
    $(".accordion-body").on("hide.bs.collapse", function(){
      $(this).prev().find('.btn-toggle').html('<i class="fas fa-chevron-down"></i>');
    });
  }
})();
