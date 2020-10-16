OWSO.DictionariesEdit = (() => {
  return {
    init
  }

  function init() {
    onClickMarkAsFeedback();
    onClickRemoveValuePair();
    onClickAddValuePair();
    initTooltip();
    validateTextLimit();
    onClickMarkAs();
  }

  function onClickMarkAs() {
    $(".item").click(function(e) {
      e.preventDefault()

      let name = $(this).data("name")
      let input = $(this).find("input")
      let checked = input.prop("checked")

      input.prop("checked", !checked)
      $(".item").not(this).removeClass("mark_as_active")
      $(this).toggleClass("mark_as_active")
      if(name == "report") $("#variable_report").trigger("click")
    })
  }

  function validateTextLimit() {
    $(".input-hint").keyup(function(){
      let currentLength = $(this).val().length
      let $hint = $(this).parent().next()
      $hint.text(`${currentLength}/${this.maxLength}`)

      if( currentLength >= this.maxLength ) {
        $(this).addClass("is-invalid")

        return false
      } else {
        $(this).removeClass("is-invalid")
      }
    })
  }

  function initTooltip() {
    $(".btn-circle").tooltip()
  }

  function onClickAddValuePair() {
    $('form .add_values').off('click')
    $('form .add_values').on('click', function(event) {
      appendField(this);
      handleRenderSatisfied();
      event.preventDefault();
    })
  }

  function handleRenderSatisfied() {
    var checkbox = $('#variable_report');
    $(".td-satisfied").toggleClass('invisible', !checkbox[0].checked);
  }

  function appendField(dom) {
    time = new Date().getTime();
    regexp = new RegExp($(dom).data('id'), 'g');
    $(dom).parents('tr').before($(dom).data('fields').replace(regexp, time));
  }

  function onClickMarkAsFeedback() {
    $('#variable_report').on('change', function(e) {
      var checkbox = $(e.target);
      var reportLabel = !!checkbox[0].checked ? "Unmark as Feedback" : "Mark as Feedback";

      checkbox.next(".report-label").text(reportLabel);
      $(".td-satisfied").toggleClass("invisible", !checkbox[0].checked);
    })
  }

  function onClickRemoveValuePair() {
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
  }
})();

OWSO.DictionariesUpdate = OWSO.DictionariesEdit
