document.addEventListener('turbolinks:load', function() {
  // let daterangepicker = new DateRangePicker('.datepicker_date', {
  //   locale: { format: 'DD/MM/YYYY'},
  //   startDate: moment().subtract(7,'d'),
  //   cancelLabel: 'Clear',
  //   alwaysShowCalendars: true,
  //   showCustomRangeLabel: true,
  //   ranges: {
  //     'Today': [moment(), moment()],
  //     'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
  //     'Last 7 Days': [moment().subtract(6, 'days'), moment()],
  //     'Last 30 Days': [moment().subtract(29, 'days'), moment()],
  //     'This Month': [moment().startOf('month'), moment().endOf('month')],
  //     'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
  //  },
  //  opens: 'left'
  // }, function(startDate, endDate, label) {

  //   var params = new URLSearchParams(location.search)
  //   params.set('start_date', startDate.format("YYYY-MM-DD"));
  //   params.set('end_date', endDate.format("YYYY-MM-DD"));

  //   var url = `${location.pathname}?${params}`
  //   window.history.replaceState({}, '', url);
  //   document.location = url;
  // })
})
