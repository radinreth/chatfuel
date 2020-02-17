document.addEventListener('turbolinks:load', function() {
  $(".dict-item").click(function(e) {
    e.preventDefault()

    var klassName = $(this).attr("data-name");
    console.log(klassName, this);

    $(".dict-item").removeClass('active');
    $(this).addClass('active');
    
    $(".result-map>table").addClass("d-none");
    $(".dict-item-"+klassName).removeClass("d-none");
  })
})
