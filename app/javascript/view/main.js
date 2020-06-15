document.addEventListener("turbolinks:load", function(){

  Owso = (function($){
    var app = {}
    
    function addPair() {
      console.log($)
    }


    // Dictionaries
    $(".table").on("click", ".dictionary-add-pair", function(e) {
      e.preventDefault()

      var lastChild = $(".value-row:last-of-type")
      var newChild = lastChild.clone()

      var input = newChild.find("input.form-control")
      var raw = $(input[0])
      var mapping = $(input[1])
      var newAttrDataIndex = +raw.data("index") + 1
      
      var oldAttrName = input[0].name
      var oldAttrId = input[0].id

      var newAttrName = oldAttrName.replace(/\d+/, newAttrDataIndex)
      var newAttrId = oldAttrId.replace(/\d+/, newAttrDataIndex)

      raw.attr({
       name: newAttrName,
       id: newAttrId,
       "data-index": newAttrDataIndex 
      })

      lastChild.after(newChild)

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