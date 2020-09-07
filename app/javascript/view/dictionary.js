OWSO.DictionariesEdit = (() => {
  return {
    init
  }

  function init() {
    onClickMarkAsFeedback();
    onClickRemoveValuePair();
    onClickAddValuePair();
    initTooltip();
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
    var checkbox = $('#variable_report_enabled');
    $(".td-satisfied").toggleClass('invisible', !checkbox[0].checked);
  }

  function appendField(dom) {
    time = new Date().getTime();
    regexp = new RegExp($(dom).data('id'), 'g');
    $(dom).parents('tr').before($(dom).data('fields').replace(regexp, time));
  }

  function onClickMarkAsFeedback() {
    $('#variable_report_enabled').on('change', function(e) {
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
