require("../patches/jquery")
import { renderChart } from '../charts/root_chart'
import formater from '../data/formater'
import { feedbackSubCategories } from "../charts/feedback_sub_categories_chart";

OWSO.WelcomesIndex = (() => {
  let logoContainer, formQuery, pilotHeader;

  let items = [
    { element: ".q_province", fromClass: "col-lg-2", toClass: "col-lg-4" },
    { element: ".q_district", fromClass: "col-lg-3", toClass: "col-lg-4" },
    { element: ".q_time_period", fromClass: "col-lg-3", toClass: "col-lg-3" }
  ];

  function init() {
    OWSO.DashboardShow.renderDatetimepicker();
    OWSO.DashboardShow.multiSelectDistricts();
    OWSO.DashboardShow.attachEventClickToChartDownloadButton();
    OWSO.DashboardShow.tooltipChart();

    onWindowScroll();
    onChangeDistrict();
    onModalSave();
    onClickTabNavigation();
    onChangePeriod();
    onLoadPopup();
  }

  function onLoadPopup() {
    // dynamic content: image, or canvas
    // update size of modal
    // update title of modal
    $("#popup").on('show.bs.modal', function (event) {
      $(".chart_feedback_by_sub_category").each(function(_, dom) {	
        let id = $(dom).data("id");
        feedbackSubCategories(dom, gon.feedbackSubCategories[id]);
      });
    });
  }

  function onChangePeriod() {
    $(document).on("change", ".access-period", function() {
      let option = {
        url: '/welcomes/q/access-info',
        self: this,
        extractor: formater.accessInfo,
        canvasId: "chart_information_access_by_period"
      }

      fetchResultSet(option)
    })

    $(document).on("change", ".track-period", function() {
      let option = {
        url: '/welcomes/q/service-tracked',
        self: this,
        extractor: formater.mostServiceTracked,
        canvasId: "chart_most_service_tracked_periodically"
      }

      fetchResultSet(option)
    })

    $(document).on("change", ".feedback-trend", function() {
      let option = {
        url: '/welcomes/q/feedback-trend',
        self: this,
        extractor: formater.feedbackTrend,
        canvasId: "chart_owso_feedback_trend"
      }

      fetchResultSet(option)
    })
  }

  function fetchResultSet(url, thiz, callback) {
    let period = $(thiz).val()
    let serializedParams = $('#q').serialize()+`&period=${period}`
    let header = $(thiz).closest(".card-header");
    let $spin = $(header.next().find(".fa-sync")[0]);

    loading($spin);

    $.get(url, serializedParams, function(result) {
      callback(result);
      loaded($spin);
    }, "json");
  }

  function loading(spin) {
    spin.removeClass("d-none");
    spin.next().css({ opacity: 0.3 });
  }

  function loaded(spin) {
    spin.addClass("d-none");
    spin.next().css({ opacity: 1 });
  }

  function onClickTabNavigation() {
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
      var target = $(e.target);
      var active = $(target).attr('href');
      $("#q_active_tab").val(active);
    })
  }

  function customChart() {
    mostRequest()
    genderInfo()
    accessInfo()
    accessMainService()
    mostTrackedPeriodically()
    ticketTrackingByGenders()

    // citizen feedback
    overallRating()
    feedbackTrend()
    feedbackSubCategories()
  }

  function feedbackSubCategories() {
    var ctx = $('.chart_feedback_by_sub_category');
    // var canvas = $('<canvas />', { class: "chart_feedback_by_sub_category" })
    // canvas.insertAfter(".chart_feedback_by_sub_category")
    // chart.feedbackSubCategories(ctx);
    $(".chart_feedback_by_sub_category").each(function(i, dom) {
      chart.feedbackSubCategories(dom);
    } )
    /*
      number of charts base on search
      each chart
        like & dislike (value)
    */
    // var data = {
    //   labels: ["Like", "Dislike"],
    //   datasets: [
    //     {
    //       label: "staff",
    //       backgroundColor: "#b7b5b3",
    //       data: [60,55]
    //     },    
    //     {
    //       label: "price",
    //       backgroundColor: "#3864B1",
    //       data: [55,80]
    //     },
    //     {
    //       label: "working hour",
    //       backgroundColor: "#D6D44C",
    //       data: [40,55]
    //     },
    //     {
    //       label: "document",
    //       backgroundColor: "#65D4BD",
    //       data: [80,45]
    //     },
    //     {
    //       label: "process",
    //       backgroundColor: "#43291F",
    //       data: [35,55]
    //     },
    //     {
    //       label: "delivery speed",
    //       backgroundColor: "#da2c38",
    //       data: [80,40]
    //     },
    //     {
    //       label: "providing info",
    //       backgroundColor: "#bdadea",
    //       data: [60,30]
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


    // $.each( $('.chart_feedback_by_sub_category'), function(_, ctx) {
    //   new Chart(ctx, {
    //     type: 'bar',
    //     data: data,
    //     plugins: [chartDataLabels],
    //     options: options
    //   });
    // } )

      $("#exampleModal").modal("hide")
    })
  }

  function feedbackTrend() {
    var ctx = 'chart_owso_feedback_trend';
    chart.feedbackTrend(ctx);
  }

  function overallRating() {
    var ctx = 'chart_overall_rating_by_owso';
    chart.overallRating(ctx);
  }

  function ticketTrackingByGenders() {
    var ctx = 'chart_ticket_tracking_by_gender';
    chart.ticketTrackingByGenders(ctx);
  }

  function mostTrackedPeriodically() {
    var ctx = 'chart_most_service_tracked_periodically'
    chart.mostTrackedPeriodic(ctx);
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
      var provinceCode = $('#province').val()
      var districtCode = $('.district_code').val().filter( e => e)

      if( districtCode.length > 0 ) {
        $.get("/welcomes/filter", 
          { province_code: provinceCode, 
            locale: gon.locale,
            district_code: districtCode }, 
          function(result) {
          $("#show-districts").text(result.display_name)
          $("#q_districts").val(districtCode)
          $(".tooltip-district")
            .attr("data-original-title", result.district_list_name)
        })
      } else {
        $("#show-districts").text(gon.all);
        $("#q_districts").val("");
        $(".tooltip-district").attr("data-original-title", "");
      }

      $("#districtsModal").modal("hide")
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
