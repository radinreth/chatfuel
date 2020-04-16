document.addEventListener('turbolinks:load', function() {
  $(".ticket-status").change(function(){
    var ticketId = $(this).data("id")
    var status = $(this).val()

    $.ajax({
      url: `/tickets/${ticketId}/`,
      type: 'PUT',
      dataType: 'script',
      data: { ticket: { status: status } },
      success: function(data) { console.log("data", data) },
      error: function(xhr, status, err) {
        console.log("error", err)
      }
    })
    .done(function( msg ) {
      console.log("done", msg)
    });
  })
})