OWSO.TemplatesIndex = (() => {
  return {
    init
  }

  function init() {
    attachEventToTemplateType()
    attachEventToAudio()
    attachEventToImage();
    onClickDeleteImage();
    OWSO.DictionariesEdit.onClickMarkAs()
  }

  function attachEventToTemplateType() {
    $(document).on("change", "#template_type", function(e) {
      $(".template_content, .template_audio, .template_image").hide();

      if ($(this).val() == "VerboiceTemplate") {
        return $(".template_audio").show();
      }

      $(".template_content").show();
      $('.template_image').show();
    })

    $("#template_type").trigger("change");
  }

  function attachEventToAudio() {
    $(document).on("change", "#template_audio", function(e) {
      var input = e.currentTarget
      var $audio = $("#newTemplateModal .modal-body").find("audio")
      var $audioName = $("#newTemplateModal .modal-body").find("#audio-name")

      readURL(input, function(result) {
        $audio.attr("src" , result);
        $audioName.text(input.files[0].name);
      })
    })
  }

  function attachEventToImage() {
    $(document).on("change", "#template_image", function(e) {
      let input = e.currentTarget;

      readURL(input, function(result) {
        $('.image-preview').attr('src', result);
        showButtonDeleteImage();
        setUncheckDeleteImage();
      })
    })
  }

  function readURL(input, callback) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function(e) {
        !!callback && callback(e.target.result);
      }

      reader.readAsDataURL(input.files[0]);
    }
  }

  function onClickDeleteImage() {
    $(document).on('click', '.btn-delete', function(e) {
      setPreviewToDefaultImage();
      setCheckDeleteImage();
      hideButtonDeleteImage();
    })
  }

  function setUncheckDeleteImage() {
    $('input[name=purge_image]').attr('checked', false);
  }

  function setPreviewToDefaultImage() {
    $('.image-preview').attr('src', $('.image-preview').data('default'));
  }

  function setCheckDeleteImage() {
    $('input[name=purge_image]').attr('checked', true);
  }

  function hideButtonDeleteImage() {
    $('.btn-delete').addClass('d-none');
  }

  function showButtonDeleteImage() {
    $('.btn-delete').removeClass('d-none');
  }
})()
