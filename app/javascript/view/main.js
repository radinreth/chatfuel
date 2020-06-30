document.addEventListener("turbolinks:load", function(){

  Owso = (function($){
    var app = {}
    
    function factory(dom) {
      let newIndex = +$(dom).data("index") + 1
      $(dom).prop("disabled", false)
            .val("")

      return {
        object: $(dom),
        name: dom.name.replace(/\d+/, newIndex),
        id: dom.id.replace(/\d+/, newIndex),
        index: newIndex
      }
    }

    // Dictionaries
    $(".table").on("click", ".dictionary-add-pair", function(e) {
      e.preventDefault()

      var lastChild = $(".value-row:last-of-type")
      var newChild = lastChild.clone()
      var input = newChild.find("input.form-control")

      var dom = factory(input[0])
      dom.object.attr({ name: dom.name, id: dom.id, "data-index": dom.index })

      dom = factory(input[1])
      dom.object.attr({ name: dom.name, id: dom.id, "data-index": dom.index })

      lastChild.after(newChild)
    })

    $(".table").on("click", ".dictionary-remove-pair", function(e) {
      e.preventDefault()
      var row = $(this).closest("tr")

      if( row.closest("tbody").children(".value-row").length > 1 ) {
        row.find(".variable-destroy").val(true)
        row.hide()
      } else {
        alert("Unable to empty dictionary")
      }
    })

    return app
  }(jQuery))
})