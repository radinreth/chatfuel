require("../patches/jquery")
import { renderChart } from '../charts/root_chart'

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
    OWSO.DashboardShow.onChangePeriod();

    onWindowScroll();
    onChangeDistrict();
    onModalSave();
    onProvinceModalSave();
    onClickTabNavigation();
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
      let provinceCode = $('.province_code').val().filter( e => e);
      let districtCode = $('.district_code').val().filter( e => e);

      let params = { 
        locale: gon.locale,
        province_code: provinceCode, 
        district_code: districtCode 
      };

      if( districtCode.length > 0 ) {
        $.get("/welcomes/filter", params, function(result) {
          updateDistrict(result, districtCode);
        })
      } else {
        resetDistrict();
      }

      $("#districtsModal").modal("hide");
    })
  }

  function updateDistrict(result, districtCode) {
    $("#show-districts").text(result.display_name);
    $("#q_districts").val(districtCode);
    $(".tooltip-district").attr("data-original-title", result.described_name);
  }

  function onProvinceModalSave() {
    $(".btn-province-save").click(function(e) {
      e.preventDefault();
      let provinceCode = $('.province_code').val().filter( e => e);
      let params = { 
        locale: gon.locale,
        province_code: provinceCode 
      };

      if( provinceCode.length == 0 ) {
        resetProvince();
        resetDistrict();
      } else  {
        $.get("/welcomes/filter", params, function(result) {
          updateProvince(result, provinceCode);

          if ( provinceCode.length == 1 ) {
            pullDistricts(provinceCode);
          } else if ( provinceCode.length > 1 ) {
            resetDistrict();
          }
        });
      }
      
      $("#provincesModal").modal("hide");
    })
  }

  function disableDistrict() {
    pumi.toggleEnableSelect(pumi.selectTarget("district"), false);
  }

  function pullDistricts(provinceCode) {
    pumi.filterSelectByValue(pumi.selectTarget("district"), provinceCode[0]);
  }

  function updateProvince(result, provinceCode) {
    $("#q_provinces").val(provinceCode);
    $("#show-provinces").text(result.display_name);
    $(".tooltip-province").attr("data-original-title", result.described_name);
  }

  function resetProvince() {
    $("#q_provinces").val("");
    $("#show-provinces").text(gon.all);
    $(".tooltip-province").attr("data-original-title", "");
  }

  function resetDistrict() {
    disableDistrict();
    $("#q_districts").val("");
    $("#show-districts").text(gon.all);
    $(".tooltip-district").attr("data-original-title", "");
    $(".district_code").val(null).trigger('change');
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

  return { init, renderChart, scrollToForm }

})()
