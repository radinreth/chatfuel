document.addEventListener('turbolinks:load', function() {
  $(".dict-item").click(function(e) {
    e.preventDefault()

    var klassName = $(this).attr("data-name");

    $(".dict-item").removeClass('active');
    $(this).addClass('active');
    
    $(".result-map table").addClass("d-none");
    $(".dict-item-" + klassName).removeClass("d-none");
  })

  $(".btn-add").click(function(e) {
    e.preventDefault()

    var name = $(this).data("name")
    var variableId = $(this).closest("table").data("variable_id")
    var index = $(".tr-js").last().data("index")

    if(index == undefined) index = 1
    else index++

    var $tr = `<tr class="tr-js" data-index="${index}">
      <td>
        <input class="form-control hidden" value="${variableId}" name="variable_value[][variable_id]" type="hidden" id="dictionaries_id">
        
        <div class="input-group">
          <div class="input-group-prepend">
            <div class="input-group-text">
              <a class="btn-del" style="cursor: pointer">X</a>
            </div>
          </div>
          <input class="form-control string required mr-sm-2" name="variable_value[][raw_value]" id="variable_value" type="text">
        </div>
      </td>

      <td>
        <div class="form-group string required dictionaries_text"><input class="form-control string required mr-sm-2" name="variable_value[][mapping_value]" id="variable_text" type="text"></div>
      </td>

      <td class="d-none">
        <div class="form-check form-check-inline">
          <input name="variable_value[][status${index}]" class="form-check-input" type="radio" value="0" id="dictionaries_status_${index}0">
          <label class="form-check-label mr-2" for="dictionaries_status_${index}0">N</label>

          <input name="variable_value[][status${index}]" class="form-check-input" type="radio" value="1" id="dictionaries_status_${index}1">
          <label class="form-check-label mr-2" for="dictionaries_status_${index}1">S</label>

          <input name="variable_value[][status${index}]" class="form-check-input" type="radio" value="2" id="dictionaries_status_${index}2">
          <label class="form-check-label" for="dictionaries_status_${index}2">D</label>
        </div>
      </td>
    </tr>`
  
    $(this).closest("tr")[0].before($($tr)[0])
  })

  $("#dictionaries-index").on("click", ".btn-del", function(e) {
    e.preventDefault()
    if( confirm("Are you sure?") ) {
      $(this).closest("tr")[0].remove()
    }
  })

  $(".btn-role").click(function(e){
    e.preventDefault()
    var roleId = $(this).data("role_id")
    var variableId = $(this).data("variable_id")

    $.ajax({
      method: "PUT",
      url: `/dictionaries/${variableId}/roles/${roleId}`
    })
    .done(function( msg ) {
      console.log("done", msg)
    });
  })
})



document.addEventListener('turbolinks:before-render', function() {
  $(".dict-item").removeClass('active');
})
