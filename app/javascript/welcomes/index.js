require("../patches/jquery")
import { renderChart } from '../charts/root_chart'
import formater from '../data/formater'
import { subCategoriesFeedback } from "../charts/citizen-feedback/feedback_sub_categories_chart";

import * as defaults from '../data/defaults'

OWSO.WelcomesIndex = (() => {
  let logoContainer, formQuery, pilotHeader;

  let items = [
    { element: ".q_province", fromClass: "col-lg-2", toClass: "col-lg-4" },
    { element: ".q_district", fromClass: "col-lg-3", toClass: "col-lg-4" },
    { element: ".q_time_period", fromClass: "col-lg-3", toClass: "col-lg-3" }
  ];

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()
    OWSO.DashboardShow.multiSelectDistricts()

    onWindowScroll()
    onChangeDistrict()
    onModalSave()
  }

  function onModalSave() {
    $(".btn-save").click(function(e) {
      var provinceCode = $('#province').val()
      var districtCode = $('.district_code').val().filter( e => e)

      if( districtCode.length > 0 ) {
        $.get("/welcomes/filter", 
          { province_code: provinceCode, 
            locale: gon.locale,
            district_code: districtCode }, 
          function(result) {
          $(".fake-control").html(result.data)
        })
      } else {
        $("#q_districts").val(gon.all)
      }

      $("#exampleModal").modal("hide")
    })
  }

  function chartPointStyle() {
    var container = document.querySelector(".root-container")
    var div = document.createElement('div');
    div.classList.add('chart-container');

    var canvas = document.createElement('canvas');
    div.appendChild(canvas);
    container.appendChild(div);

    var ctx = canvas.getContext('2d');
    var config = {
      type: 'line',
      data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [{
          label: 'My First dataset',
          backgroundColor: "#f00",
          borderColor: "#f00",
          data: [10, 23, 5, 99, 67, 43, 0],
          fill: false,
          pointRadius: 5,
          pointHoverRadius: 10,
          showLine: false // no line shown
        }]
      },
      options: {
        responsive: true,
        title: {
          display: true,
          text: 'Point Style: circle'
        },
        legend: {
          display: false
        },
        elements: {
          point: {
            pointStyle: "circle"
          }
        }
      }

      fetchResultSet(option);
    });
  }

  function chartInformationAccessByGender() {
    var ctx = 'chart_information_access_by_gender'

    var data = {
      labels: ["Female", "Male", "Other"],
      total: 944,
      datasets: [
            {
              backgroundColor: ["#469BA2", "#C2E792", "#D77256"],
              data: [450, 350, 144],
            }
          ]
        };

    var options = {
      legend: {
        position: "left",
        labels: {
          boxWidth: 12,
          generateLabels: function (chart) {
            var data = chart.data
            return chart.data.labels.map(function(label, i) {
              var meta = chart.getDatasetMeta(0);
              var ds = data.datasets[0];
              var arc = meta.data[i];
              var custom = arc && arc.custom || {};
              var getValueAtIndexOrDefault = Chart.helpers.getValueAtIndexOrDefault;
              var arcOpts = chart.options.elements.arc;
              var fill = custom.backgroundColor ? custom.backgroundColor : getValueAtIndexOrDefault(ds.backgroundColor, i, arcOpts.backgroundColor);
              var stroke = custom.borderColor ? custom.borderColor : getValueAtIndexOrDefault(ds.borderColor, i, arcOpts.borderColor);
              var bw = custom.borderWidth ? custom.borderWidth : getValueAtIndexOrDefault(ds.borderWidth, i, arcOpts.borderWidth);
              var perc = parseFloat(ds.data[i] / chart.data.total*100).toFixed(2)

              return {
                text: `${label} (${perc}%)`,
                fillStyle: fill,
                strokeStyle: stroke,
                lineWidth: bw,
                hidden: isNaN(ds.data[i]) || meta.data[i].hidden,
                index: i
              }
            })
          }
        }
      },
      plugins: {
        datalabels: {
          color: "#FFF"
        }
      }
    }

    loading($spin);
    let chart = OWSO.Util.findChartInstance(canvasId)

    $.get(url, serializedParams, function(result) {
      chart.data = extractor(result);
      let max = _.max(chart.data.datasets[0].data);
      let suggestedMax = Math.round( max * 1.40 );
      chart.options.scales.yAxes[0].ticks.suggestedMax = suggestedMax;

      chart.update();

      loaded($spin);
    }, "json");
  }

  function chartMostRequestedServices() {
    var ctx = 'chart_most_requested_services'

    var { label, colors, peak, data } = gon.mostRequestedServices
    var labels = Object.keys(data)
    var titles = Object.values(data).map(e => e.value)
    var values = Object.values(data).map(e => e.count)

    data = {
      labels: labels,
      datasets: [
            {
              label: label,
              backgroundColor: colors,
              data: values,
              maxBarThickness: 36,
              minBarLength: 2,
              dataTitles: titles
            }
          ]
        };
    var options = { 
        plugins: {
          datalabels: {
            anchor: "end",
            align: "end",
            rotation: 0,
            textAlign: "center",
            formatter: function(value, context) {
              var label = context.dataset.dataTitles[context.dataIndex]
              return label + "\n" + value;
            }
          }
        },
        legend: {
          display: false
        },
        scales: {
          yAxes: [{
            display: true,
            ticks: {
              // stepSize: 200,
              suggestedMax: (peak + 200),
              beginAtZero: true
            }
          }],
          xAxes: [{
            gridLines: {
              display: false
            },
            ticks: {
              autoSkip: false,
              maxRotation: 45,
              minRotation: 45,
              callback: function(value) {
                var maxLength = 10;
                if( value.length >= maxLength ) {
                  return `${value.substr(0, 10)}...`;
                } else {
                  return value;
                }
              },
            }
          }]
        }
    };

  function loaded(spin) {
    spin.addClass("d-none");
    spin.next().css({ opacity: 1 });
  }

  function chartInformationAccessByGender() {
    var ctx = 'chart_information_access_by_gender'

    var data = {
      labels: ["Female", "Male", "Other"],
      total: 944,
      datasets: [
            {
              backgroundColor: ["#469BA2", "#C2E792", "#D77256"],
              data: [450, 350, 144],
            }
          ]
        };

    var options = {
      legend: {
        position: "left",
        labels: {
          boxWidth: 12,
          generateLabels: function (chart) {
            var data = chart.data
            return chart.data.labels.map(function(label, i) {
              var meta = chart.getDatasetMeta(0);
              var ds = data.datasets[0];
              var arc = meta.data[i];
              var custom = arc && arc.custom || {};
              var getValueAtIndexOrDefault = Chart.helpers.getValueAtIndexOrDefault;
              var arcOpts = chart.options.elements.arc;
              var fill = custom.backgroundColor ? custom.backgroundColor : getValueAtIndexOrDefault(ds.backgroundColor, i, arcOpts.backgroundColor);
              var stroke = custom.borderColor ? custom.borderColor : getValueAtIndexOrDefault(ds.borderColor, i, arcOpts.borderColor);
              var bw = custom.borderWidth ? custom.borderWidth : getValueAtIndexOrDefault(ds.borderWidth, i, arcOpts.borderWidth);
              var perc = parseFloat(ds.data[i] / chart.data.total*100).toFixed(2)

              return {
                text: `${label} (${perc}%)`,
                fillStyle: fill,
                strokeStyle: stroke,
                lineWidth: bw,
                hidden: isNaN(ds.data[i]) || meta.data[i].hidden,
                index: i
              }
            })
          }
        }
      },
      plugins: {
        datalabels: {
          color: "#FFF"
        }
      }
    }

    new Chart(ctx, {
      type: 'pie',
      data: data,
      plugins: [chartDataLabels],
      options: options
    });
  }

  function chartMostRequestedServices() {
    let ctx = 'chart_most_requested_services'
    let type = 'bar', plugins = [chartDataLabels]

    let { label, colors, max, dataset } = gon.mostRequestedServices
    let [labels, values] = [_.keys(dataset), _.values(dataset)]
    let titles = _.map(values, el => el.value)
    let counts = _.map(values, el => el.count)

    let data = {
      labels: labels,
      datasets: [
        {
          ...defaults.initData,
          label: label,
          backgroundColor: colors,
          dataTitles: titles,
          data: counts,
        }
      ]
    }

    let options = {
      ...defaults.initOptions,
      scales: {
        ...defaults.initOptions.scales,
        yAxes: [{
          display: true,
          ticks: {
            // extra margin needed to avoid clip label on bar chart
            suggestedMax: (max + 200),
          }
        }]
      }
    }

    new Chart(ctx, { type, plugins, data, options });
  }

  function onModalSave() {
    $(".btn-save").click(function(e) {
      e.preventDefault();
      let provinceCode = $('#province').val();
      let districtCode = $('.district_code').val().filter( e => e);
      let params = { 
        province_code: provinceCode, 
        locale: gon.locale,
        district_code: districtCode 
      };

      if( districtCode.length > 0 ) {
        $.get("/welcomes/filter", params, function(result) {
          $("#show-districts").text(result.display_name);
          $("#q_districts").val(districtCode);
          $(".tooltip-district").attr("data-original-title", result.district_list_name);
        })
      } else {
        $("#show-districts").text(gon.all);
        $("#q_districts").val("");
        $(".tooltip-district").attr("data-original-title", "");
      }

      $("#districtsModal").modal("hide");
    })
  }

  

  function onWindowScroll() {
    formQuery = $("#form-query")
    logoContainer = $("#logo-container")
    pilotHeader = $("#piloting-header")
    window.onscroll = () => { stickOnScroll() }
  }

  function onChangeDistrict() {
    $(document).on("change", "#district", function(e) {
      if( e.target.disabled ) {
        $("#time_period, #btn-search").prop("disabled", true);
      } else {
        $("#time_period, #btn-search").prop("disabled", false);
      }
    })
  }

  function stickOnScroll() {
    if(window.pageYOffset >= (logoContainer.outerHeight() + pilotHeader.offset().top) ) {
      $(".logo-inline").show()
      formQuery.addClass('highlight')
      $(".switch-lang").addClass('inc-top');
      decreaseFormControlWidth()
    } 
    
    if(window.pageYOffset < pilotHeader.offset().top) {
      $(".logo-inline").hide()
      formQuery.removeClass('highlight')
      $(".switch-lang").removeClass('inc-top');
      increaseFormControlWidth()
    }
  }

  function decreaseFormControlWidth() {
    $.each(items, function(_, item) {
      let { element, fromClass, toClass } = item;
      $(element).replaceClass(toClass, fromClass);
    })
  }

  function increaseFormControlWidth() {
    $.each(items, function(_, item) {
      let { element, fromClass, toClass } = item;
      $(element).replaceClass(fromClass, toClass);
    })
  }

  function scrollToForm() {
    $([document.documentElement, document.body]).animate({
      scrollTop: (formQuery.outerHeight() + formQuery.offset().top)
    }, 500);
  }

  return { init, renderChart, loadSubCategories, scrollToForm }

})()
