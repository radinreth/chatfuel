document.addEventListener('turbolinks:load', function() {
  $('.switch-language').on('ajax:success', function(e, data, status, xhr) {
    window.location.reload();
  })
});
