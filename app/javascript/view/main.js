document.addEventListener("turbolinks:load", function(){

  var OwsoApp = (function($){
    var app = {}
    
    function addPair() {
      console.log($)
    }

    $(".table").on("click", ".dictionary-add-pair", function(e) {
      e.preventDefault()
      var lastChild = $(".value-row:last-of-type")
      var html = lastChild.get(0).outerHTML

      lastChild.after(html)
    })

    $(".table").on("click", ".dictionary-remove-pair", function(e) {
      e.preventDefault()
      var row = $(this).closest("tr")

      console.log( row.closest("tbody").children(".value-row").length )
      if( row.closest("tbody").children(".value-row").length > 1 ) {
        row.remove()
      } else {
        alert("Unable to empty dictionary")
      }
    })

    app.addPair = addPair

    return app
  }(jQuery))
})