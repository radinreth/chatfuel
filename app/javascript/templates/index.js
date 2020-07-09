OWSO.TemplatesIndex = (() => {
  function init() {
    attachEventToTemplateType()
    attachEventToAudio()
  }

  function attachEventToTemplateType() {
    $(document).on("change", "#template_type", function(e) {
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
    $(document).on("change", "#template_audio", function(e) {
      
      var target = e.currentTarget
      var file = target.files[0]
      var $audio = $(".modal-body").find("audio")
      var $audioName = $(".modal-body").find("#audio-name")

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
