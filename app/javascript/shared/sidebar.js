(function() {
  document.addEventListener('turbolinks:load', function() {
    var handleActiveSidebar, init, onClickSidebar;
    init = function() {
      handleActiveSidebar();
      return onClickSidebar();
    };
    handleActiveSidebar = function() {
      var cssClass;
      cssClass = localStorage.getItem('miniSidebar') === 'true' ? 'active' : '';
      return $('#sidebar').addClass(cssClass);
    };
    onClickSidebar = function() {
      return $('#sidebarCollapse').on('click', function() {
        $('#sidebar').toggleClass('active');
        return localStorage.setItem('miniSidebar', $('#sidebar').hasClass('active'));
      });
    };
    return init();
  });

}).call(this);
