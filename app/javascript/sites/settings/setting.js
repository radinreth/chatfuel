OWSO.SiteSettings = (() => {
  return {
    init
  }

  function init() {
    addEventToMessageVariable();
  }

  function addEventToMessageVariable() {
    $('.message-setting-variable').click((e) => {
      messageVarible = $(e.target).text();
      messageTemplateDom = $("#site_setting_message_template")
      insertAtCursor(messageTemplateDom[0], messageVarible);
    });
  }

  function insertAtCursor (input, textToInsert) {
    // get current text of the input
    const value = input.value;

    // save selection start and end position
    const start = input.selectionStart;
    const end = input.selectionEnd;

    // update the value with our text inserted
    input.value = value.slice(0, start) + textToInsert + value.slice(end);

    // update cursor to be at the end of insertion
    input.selectionStart = input.selectionEnd = start + textToInsert.length;
  }
})();

OWSO.SitesSettingsNew = OWSO.SiteSettings
OWSO.SitesSettingsCreate = OWSO.SiteSettings
OWSO.SitesSettingsEdit = OWSO.SiteSettings
OWSO.SitesSettingsUpdate = OWSO.SiteSettings
