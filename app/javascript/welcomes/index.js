require("../patches/jquery")
import * as chart from '../factories/root_chart'

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
    mostRequest()
    genderInfo()
    accessInfo()
    accessMainService()
    mostRequestedPeriodically()
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

  function mostRequestedPeriodically() {
    var ctx = 'chart_most_service_tracked_periodically'
    chart.mostRequestPeriodic(ctx);
  }

  function accessMainService() {
    var ctx = 'chart_number_access_by_main_services';
    chart.accessMainService(ctx);
  }

  // access owso info by period { month, quater, semester }
  function accessInfo() {
    var ctx = 'chart_information_access_by_period';
    chart.accessInfo(ctx);
  }

  function genderInfo() {
    let ctx = 'chart_information_access_by_gender';
    chart.genderInfo(ctx);
  }

  function mostRequest() {
    let ctx = 'chart_most_requested_services';
    chart.mostRequest(ctx)
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
            .attr("data-original-title", result.district_list_name)
        })
      } else {
        $("#q_districts").val(gon.all)
      }

      $("#exampleModal").modal("hide")
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