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

    var $tr = `<tr>
      <td>
        <div class="form-group hidden dictionaries_id"><input class="form-control hidden" value="" name="variable[][id]" type="hidden" id="dictionaries_id"></div>
        <div class="form-group hidden dictionaries_id"><input class="form-control hidden" value="${name}" name="variable[][name]" type="hidden" id="dictionaries_name"></div>
        <div class="form-group string required dictionaries_value"><input class="form-control string required mr-sm-2" name="variable[][value]" id="variable_value" type="text"></div>
      </td>

      <td>
        <div class="form-group string required dictionaries_text"><input class="form-control string required mr-sm-2" name="variable[][text]" id="variable_text" type="text"></div>
      </td>
    </tr>`
  
    $(this).closest("tr")[0].before($($tr)[0])
  })
})



document.addEventListener('turbolinks:before-render', function() {
  $(".dict-item").removeClass('active');
})
