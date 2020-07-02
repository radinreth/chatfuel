document.addEventListener('turbolinks:load', function() {
  $(document).on("click", ".variable_report_enabled", function(){
    var checkbox = $('.variable-report-enabled')
    var reportLabel = "Mark as Feedback"

    if( checkbox[0] && checkbox[0].checked ) {
      reportLabel = "Unmark as Feedback"
    }

    checkbox.next(".report-label").text(reportLabel)
    $(".td-satisfied").toggleClass("invisible")
  })

  $(document).on("change", "#province", function(e) {
    var province = $(this).val()

    var params = new URLSearchParams(location.search)
    params.set('location', province);

    var url = `${location.pathname}?${params}`
    window.history.replaceState({}, '', url);
    document.location = url;
  })
})
