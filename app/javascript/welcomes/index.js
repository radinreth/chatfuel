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
    ticketTrackingByGenders()

    // citizen feedback
    overallRating()
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

  function overallRating() {
    var ctx = 'chart_overall_rating_by_owso'
    chart.overallRating(ctx);
    

    // var data = {
    //   labels: ["kamrieng", "bavel", "tmor kol"],
    //   datasets: [
    //     {
    //       label: "Like",
    //       backgroundColor: "#65D4BD",
    //       data: [60,50,40]
    //     },    
    //     {
    //       label: "Acceptable",
    //       backgroundColor: "#2855BE",
    //       data: [10,80,50]
    //     },
    //     {
    //       label: "Dislike",
    //       backgroundColor: "#C1413B",
    //       data: [40,55,90]
    //     }
    //   ]
    // }

    // var options = {
    //   plugins: {
    //     datalabels: {
    //       display: false,
    //       rotation: -90,
    //       color: "#FFF",
    //       textAlign: "center",
    //       formatter: function(value, context) {
    //         return context.dataset.label;
    //       }
    //     }
    //   },
    //   barValueSpacing: 20,
    //   scales: {
    //     yAxes: [{
    //       ticks: {
    //         max: 100,
    //         min: 0,
    //       }
    //     }]
    //   }
    // }

    // new Chart(ctx, {
    //   type: 'bar',
    //   data: data,
    //   plugins: [chartDataLabels],
    //   options: options
    // });

  }

  function ticketTrackingByGenders() {
    var ctx = 'chart_ticket_tracking_by_gender';
    chart.ticketTrackingByGenders(ctx);
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