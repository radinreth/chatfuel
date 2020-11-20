(function ($) {
  $.fn.replaceClass = function (pFromClass, pToClass) {
    return this.removeClass(pFromClass).addClass(pToClass);
  };
}(jQuery));

OWSO.WelcomesIndex = (() => {
  var logoContainer, formQuery, pilotHeader

  let items = [
    { element: ".q_province", fromClass: "col-lg-2", toClass: "col-lg-4" },
    { element: ".q_district", fromClass: "col-lg-3", toClass: "col-lg-4" },
    { element: ".q_time_period", fromClass: "col-lg-3", toClass: "col-lg-3" }
  ]

  function init() {
    OWSO.DashboardShow.renderDatetimepicker()
    OWSO.DashboardShow.multiSelectDistricts()

    onWindowScroll()
    onChangeDistrict()
    onModalSave()
  }

  function customChart() {
    chartMostRequestedServices()
    chartInformationAccessByGender()
    chartInformationAccessByPeriod()
  }

  function chartInformationAccessByPeriod() {
    var ctx = 'chart_information_access_by_period'

    var data = {
      labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
      datasets: [
            {
              backgroundColor: ["#F2A33A", "#5ACAFA", "#5CB836", "#F2A33A", "#5ACAFA", "#F2A33A"],
              borderColor: "rgba(151,187,205,1)",
              data: [200, 500, 350, 250, 330, 360],
              maxBarThickness: 36,
              minBarLength: 2,
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
              return value;
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
              stepSize: 200,
              suggestedMax: 700,
              beginAtZero: true
            }
          }],
          xAxes: [{
            gridLines: {
              display: false
            },
            ticks: {
              autoSkip: false,
              maxRotation: 0,
              minRotation: 0
            }
          }]
        }
    };

    new Chart(ctx, {
        type: 'bar',
        data: data,
        plugins: [chartDataLabels],
        options: options
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
            // debugger
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
    var ctx = 'chart_most_requested_services'

    var data = {
      labels: ["Bavel", "Thmor Kol", "Kamrieng", "Battambang"],
      datasets: [
            {
              label: "Most requested services by OWSO",
              backgroundColor: ["#ff6384", "#36a2eb", "#cc65fe", "#ffce56"],
              borderColor: "rgba(151,187,205,1)",
              data: [200, 500, 350, 250],
              maxBarThickness: 36,
              minBarLength: 2,
              dataTitles: ["Document\nCertification", "Public\nTransport", "Document\nCertification", "Public\nTransport"]
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
              stepSize: 200,
              suggestedMax: 800,
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
              minRotation: 45
            }
          }]
        }
    };

    new Chart(ctx, {
        type: 'bar',
        data: data,
        plugins: [chartDataLabels],
        options: options
    });
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
          $("#q_districts").val(result.display_name)
          $(".tooltip-district")
            .attr("data-original-title", result.district_list_name || result.display_name)
        })
      } else {
        $("#q_districts").val(gon.all)
      }

      $("#exampleModal").modal("hide")
    })
  }

  function chartPointStyle() {
    var container = document.querySelector(".root-container")

    if( container == null ) return

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
    };
    new Chart(ctx, config);
  }

  function onWindowScroll() {
    formQuery = $("#form-query")
    switchLang = $(".switch-lang")
    logoContainer = $("#logo-container")
    pilotHeader = $("#piloting-header")
    window.onscroll = () => { stickOnScroll() }
  }

  function onChangeDistrict() {
    $(document).on("change", "#district", function(e) {
      if( e.target.disabled ) {
        $("#time_period, #btn-search").prop("disabled", true)
      } else {
        $("#time_period, #btn-search").prop("disabled", false)
      }
    })
  }

  function stickOnScroll() {
    if(window.pageYOffset >= (logoContainer.outerHeight() + pilotHeader.offset().top) ) {
      $(".logo-inline").show()
      formQuery.addClass('highlight')
      switchLang.addClass('inc-top');
      decreaseFormControlWidth()
    } 
    
    if(window.pageYOffset < pilotHeader.offset().top) {
      $(".logo-inline").hide()
      formQuery.removeClass('highlight')
      switchLang.removeClass('inc-top');
      increaseFormControlWidth()
    }
  }

  function decreaseFormControlWidth() {
    $.each(items, function(_, item) {
      var { element, fromClass, toClass } = item
      $(element).replaceClass(toClass, fromClass)
    })
  }

  function increaseFormControlWidth() {
    $.each(items, function(_, item) {
      var { element, fromClass, toClass } = item
      $(element).replaceClass(fromClass, toClass)
    })
  }

  return { init, chartPointStyle, customChart }

})()