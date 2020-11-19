require("../patches/jquery")
import { renderChart } from '../charts/root_chart'
import formater from '../data/formater'
import { subCategoriesFeedback } from "../charts/citizen-feedback/feedback_sub_categories_chart";

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

  function fetchResultSet({ url, target, extractor, canvasId }) {
    let period = $(target).val()
    let serializedParams = $('#q').serialize()+`&period=${period}`
    let header = $(target).closest(".card-header");
    let $spin = $(header.next().find(".loading")[0]);

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
      let target = $(e.target);
      let active = $(target).attr('href');
      $("#q_active_tab").val(active);
    })
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
    formQuery = $("#form-query");
    logoContainer = $("#logo-container");
    pilotHeader = $("#piloting-header");
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
    // Additional padding to prevent early or late
    // highlighting floating header
    let scroll = { DOWN: 60, UP: 9 };

    if(window.pageYOffset >= (logoContainer.outerHeight() + pilotHeader.offset().top - scroll.UP) ) {
      $(".logo-inline").show();
      formQuery.addClass('highlight');
      $(".switch-lang").addClass('inc-top');
      decreaseFormControlWidth();
    } 

    if(window.pageYOffset < (pilotHeader.offset().top - scroll.DOWN)) {
      $(".logo-inline").hide();
      formQuery.removeClass('highlight');
      $(".switch-lang").removeClass('inc-top');
      increaseFormControlWidth();
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
