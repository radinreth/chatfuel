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

  function customChart() {
    mostRequest()
    genderInfo()
    accessInfo()
    accessMainService()
    mostRequestedPeriodically()
    ticketTrackingByGenders()

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

  function ticketTrackingByGenders() {
    var ctx = 'chart_ticket_tracking_by_gender';
    chart.ticketTrackingByGenders(ctx);
  }

      chart.update();

      loaded($spin);
    }, "json");
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
