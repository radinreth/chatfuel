// import { userVisit } from "../charts/total_user_visit_by_category_chart";

// var Chart = require("chart.js/dist/Chart.bundle");
window.chartDataLabels = require("chartjs-plugin-datalabels/dist/chartjs-plugin-datalabels");
// import ChartDataLabels from "chartjs-plugin-datalabels/dist/chartjs-plugin-datalabels";
window._ = require("underscore");
import { extractDonutDataset } from "../utils/donut_chart";
import { labels } from "../data/donutchart/defaults";

Chart.defaults.global.plugins.datalabels = {
  formatter: Math.round,
  backgroundColor: (context) => context.dataset.backgroundColor,
  borderColor: "white",
  borderRadius: 100,
  color: "white",
  display: false,
  font: {
    family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
    weight: "bold",
  },
  borderWidth: 1,
  padding: function (context) {
    var index = context.dataIndex;
    var value = context.dataset.data[index];
    return value < 10 ? { left: 6, right: 6, top: 3, bottom: 3 } : 5;
  },
  display: true,
};

$(document).ready(function () {
  try {
    totalVisitChart();
    totalFeedbackChart();
    // userVisit.render();
  } catch (e) {
    $(".error-message").html(e.message);
  }
});

function totalFeedbackChart() {
  try {
    let data = extractDonutDataset(gon.totalUserFeedback);

    new Chart("total_user_feedback", {
      data,
      type: "doughnut",
      options: {
        legend: {
          position: "left",
          labels,
        },
        cutoutPercentage: 80,
        animation: false, // not relate but should disable
      },
    });
  } catch (e) {
    console.log(e.message);
  }
}

function totalVisitChart() {
  try {
    let data = extractDonutDataset(gon.totalUserVisitByCategory);
    $(".error-message").text(chartDataLabels);

    new Chart("chart_total_user_visit", {
      data,
      type: "doughnut",
      plugins: [chartDataLabels],
      options: {
        legend: {
          position: "left",
          labels,
        },
        cutoutPercentage: 80,
        animation: false, // not relate but should disable
      },
    });
  } catch (e) {
    console.log(e.message);
  }
}
