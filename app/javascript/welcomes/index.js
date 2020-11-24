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
    chartNumberAccessByMainServices()
    chartMostServiceTrackedPeriodically()
    chartTicketTrackingByGender()

    // citizen feedback
    chartOverallRatingByOwso()
    chartOwsoFeedbackTrend()
    chartFeedbackBySubCategory()
  }

  function chartFeedbackBySubCategory() {
    // var ctx = $('.chart_feedback_by_sub_category');

    var data = {
      labels: ["Like", "Dislike"],
      datasets: [
        {
          label: "staff",
          backgroundColor: "#b7b5b3",
          data: [60,55]
        },    
        {
          label: "price",
          backgroundColor: "#3864B1",
          data: [55,80]
        },
        {
          label: "working hour",
          backgroundColor: "#D6D44C",
          data: [40,55]
        },
        {
          label: "document",
          backgroundColor: "#65D4BD",
          data: [80,45]
        },
        {
          label: "process",
          backgroundColor: "#43291F",
          data: [35,55]
        },
        {
          label: "delivery speed",
          backgroundColor: "#da2c38",
          data: [80,40]
        },
        {
          label: "providing info",
          backgroundColor: "#bdadea",
          data: [60,30]
        }
      ]
    }

    var options = {
      plugins: {
        datalabels: {
          display: false,
          rotation: -90,
          color: "#FFF",
          textAlign: "center",
          formatter: function(value, context) {
            return context.dataset.label;
          }
        }
      },
      barValueSpacing: 20,
      scales: {
        yAxes: [{
          ticks: {
            max: 100,
            min: 0,
          }
        }]
      }
    }


    $.each( $('.chart_feedback_by_sub_category'), function(_, ctx) {
      new Chart(ctx, {
        type: 'bar',
        data: data,
        plugins: [chartDataLabels],
        options: options
      });
    } )

  }

  function chartOwsoFeedbackTrend() {
    var ctx = 'chart_owso_feedback_trend'

    var data = {
      labels: ["January", "February", "March", "April"],
      datasets: [
        {
          label: "Like",
          backgroundColor: "#65D4BD",
          data: [60,55,40, 45]
        },    
        {
          label: "Acceptable",
          backgroundColor: "#2855BE",
          data: [55,80,50, 60]
        },
        {
          label: "Dislike",
          backgroundColor: "#C1413B",
          data: [40,55,90, 75]
        }
      ]
    }

    var options = {
      plugins: {
        datalabels: {
          display: false,
          rotation: -90,
          color: "#FFF",
          textAlign: "center",
          formatter: function(value, context) {
            return context.dataset.label;
          }
        }
      },
      barValueSpacing: 20,
      scales: {
        yAxes: [{
          ticks: {
            max: 100,
            min: 0,
          }
        }]
      }
    }

    new Chart(ctx, {
      type: 'bar',
      data: data,
      plugins: [chartDataLabels],
      options: options
    });

  }

  function chartOverallRatingByOwso() {
    var ctx = 'chart_overall_rating_by_owso'

    var data = {
      labels: ["kamrieng", "bavel", "tmor kol"],
      datasets: [
        {
          label: "Like",
          backgroundColor: "#65D4BD",
          data: [60,55,40]
        },    
        {
          label: "Acceptable",
          backgroundColor: "#2855BE",
          data: [55,80,50]
        },
        {
          label: "Dislike",
          backgroundColor: "#C1413B",
          data: [40,55,90]
        }
      ]
    }

    var options = {
      plugins: {
        datalabels: {
          display: false,
          rotation: -90,
          color: "#FFF",
          textAlign: "center",
          formatter: function(value, context) {
            return context.dataset.label;
          }
        }
      },
      barValueSpacing: 20,
      scales: {
        yAxes: [{
          ticks: {
            max: 100,
            min: 0,
          }
        }]
      }
    }

    new Chart(ctx, {
      type: 'bar',
      data: data,
      plugins: [chartDataLabels],
      options: options
    });

  }

  function chartTicketTrackingByGender() {
    var ctx = 'chart_ticket_tracking_by_gender'

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

  function chartMostServiceTrackedPeriodically() {
    var ctx = 'chart_most_service_tracked_periodically'

    var data = {
      labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
      datasets: [
            {
              label: "Most Service Tracked by Month",
              backgroundColor: ["#F2A33A", "#5ACAFA", "#5CB836", "#F2A33A", "#5ACAFA", "#F2A33A"],
              borderColor: "rgba(151,187,205,1)",
              data: [200, 500, 350, 250, 330, 360],
              maxBarThickness: 36,
              minBarLength: 2,
              dataTitles: ["Document\nCertification", "Public\nTransport", "Document\nCertification", "Public\nTransport", "Land\nTitle", "Business"]
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

  function chartNumberAccessByMainServices() {
    var ctx = 'chart_number_access_by_main_services';

    var data = {
        labels: ['Document Certification', 'Land Title', 'Public Transport', 'Construction', 'Business Plan', 'Land Refill'],
        datasets: [{
          backgroundColor: "#F2A33A",
          data: [400, 145, 202, 102, 124, 50],
          fill: false,
          pointRadius: 5,
          pointHoverRadius: 10,
          showLine: false // no line shown
        }]
      };

    var options = {
      plugins: {
        datalabels: {
          anchor: "end",
          align: "end",
          rotation: 0,
          textAlign: "center",
          formatter: function(value) {
            return value;
          }
        }
      },
      responsive: true,
      title: {
        display: false,
      },
      legend: {
        display: false
      },
      elements: {
        point: {
          pointStyle: "circle"
        }
      },
      scales: {
        yAxes: [{
          display: true,
          ticks: {
            stepSize: 250,
            suggestedMax: 500,
            beginAtZero: true
          }
        }],
        xAxes: [{
          ticks: {
            autoSkip: false,
            maxRotation: 45,
            minRotation: 45,
            beginAtZero: true,
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
    }

    new Chart(ctx, {
      type: 'line',
      data: data,
      plugins: [chartDataLabels],
      options: options
  });
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

  return { init, customChart }

})()