document.addEventListener('turbolinks:load', function() {

  $("#template_type").change(function() {
    var val = $(this).val()

    $(".template_content, .template_audio").hide()

    if( val == "MessengerTemplate" || val == "TelegramTemplate" ) {
      $(".template_content").show()
    } else {
      $(".template_audio").show()
    }
  })

  $("#template_type").trigger("change")

})
