OWSO.TemplatesIndex = (() => {
  function init() {
    attachEventToTemplateType()
    attachEventToAudio()
  }

  function attachEventToTemplateType() {
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
  }

  function attachEventToAudio() {
    $("#template_audio").change(function(e) {
      var target = e.currentTarget
      var file = target.files[0]
      var $audio = $("#audio")
      var $audioName = $("#audio-name")

      if (target.files && file) {
        var reader = new FileReader();
        reader.onload = function(e) {
          $audio.attr("src" , e.target.result )
          $audioName.text(file.name)
        }
        reader.readAsDataURL(file)
      }
      
    })
  }

  return { init }
})()
