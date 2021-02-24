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
    ssbInterceptor();
  }

  function ssbInterceptor() {
    $(".ssb-icon").click(function(){
      let site = $(this).data("site");

      $.ajax({
        url: '/api/v1/social_providers',
        type: 'post',
        data: {social_provider: {provider_name: site}},
        dataType: 'json',
      });
    });
  }

  function onLoadPopup() {
    $("#popup").on('show.bs.modal', function (event) {
      let btn = $(event.relatedTarget);
      let element = btn.data("element");
      let modal = $(this);

      let attrs = {
        size: btn.data("size"),
        title: btn.data("title"),
        body: $(element).html(),
        callback: btn.data("callback")
      }

      setupModal(modal, attrs);
    });
  }

  function setupModal(modal, { size, title, body, callback }) {
    modal.find(".modal-dialog").removeClass("modal-xl").addClass(size);
    modal.find(".modal-title").text(title);
    let modalBody = modal.find(".modal-body");
    if( modalBody.data("state") == "prune" ) {
      modalBody.html(body);
      $(".sub_categories").html("");
      modalBody.data("state", "replaced");
    }

    if( callback !== undefined ) {
      OWSO.WelcomesIndex[callback]();
    }
  }

  function loadSubCategories() {
    $(".chart_feedback_by_sub_category").each(function(_, dom) {	
      let id = $(dom).data("id");
      let ds = gon.feedbackSubCategories[id];

      if( ds != undefined ) {
        subCategoriesFeedback.chartId = dom.id;
        subCategoriesFeedback.ds = ds;
        subCategoriesFeedback.render();
      }
    });
  }

  function onChangePeriod() {
    $(document).on("change", ".period-filter", function() {
      let path = $(this).data("resourcepath");
      let url = `/welcomes/q/${path}`;

      let option = {
        url: url,
        target: this,
        extractor: formater[$(this).data("formater")],
        canvasId: $(this).data("canvasid")
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
