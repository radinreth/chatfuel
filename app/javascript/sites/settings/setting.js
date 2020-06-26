OWSO.SiteSettings = (() => {
  return {
    init
  }

  function init() {
    addEventToMessageVariable();
    addEventToDigestMessageVariable();
    initBootstrapToggle();
  }

  function initBootstrapToggle() {
    $('#toggle-notification').bootstrapToggle();
  }

  function addEventToMessageVariable() {
    $(".message-setting-variable").click((e) => {
      messageVarible = $(e.target).text();
      messageTemplateDom = $("#site_setting_message_template")
      insertAtCursor(messageTemplateDom[0], messageVarible);
    });
  }

  function addEventToDigestMessageVariable() {
    $(".digest-message-setting-variable").click((e) => {
      digestMessageVariable = $(e.target).text();
      digestMessageTemplateDom = $("#site_setting_digest_message_template")
      insertAtCursor(digestMessageTemplateDom[0], digestMessageVariable);
    });
  }

  function insertAtCursor (input, textToInsert) {
    const value = input.value;
    const start = input.selectionStart;
    const end = input.selectionEnd;

    input.value = value.slice(0, start) + textToInsert + value.slice(end);
    input.selectionStart = input.selectionEnd = start + textToInsert.length;
  }

})();

OWSO.SitesSettingsShow = OWSO.SiteSettings
