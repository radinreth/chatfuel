OWSO.Provincial_usagesIndex = (() => {
  function init() {
    OWSO.DashboardShow.renderDatetimepicker();
    OWSO.DashboardShow.onChangeProvince();
    OWSO.DashboardShow.multiSelectDistricts();
    attachEventClickToExpandedButton();
  }

  return { init };
})();
