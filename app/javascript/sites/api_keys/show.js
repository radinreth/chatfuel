OWSO.SitesApi_keysShow = (() => {
  return {
    init
  }

  function init() {
    $('[data-toggle="tooltip"]').tooltip();
    onClickBtnRegenerateToken();
    onClickBtnCopyToken();
  }

  function hex(num) {
    let n = num || 16;
    result = '';

    for (var i = n - 1; i >= 0; i--) {
      result += Math.floor(Math.random() * 16).toString(16);
    }

    return result;
  }

  function onClickBtnRegenerateToken() {
    $(document).off('click', '.btn-regenerate-token');
    $(document).on('click', '.btn-regenerate-token', function(event) {
      let key = hex(32);
      $('.access-token-view').html(key);
      $('.access-token').val(key);
    })
  }
  function onClickBtnCopyToken() {
    $(document).off('click', '.btn-copy');
    $(document).on('click', '.btn-copy', function(event) {
      const el = document.createElement('textarea');
      el.value = $('.token').html();
      el.setAttribute('readonly', '');
      el.style.position = 'absolute';
      el.style.left = '-9999px';
      document.body.appendChild(el);
      el.select();
      document.execCommand('copy');
      document.body.removeChild(el);
    });
  }
})();

