// window.chartDataLabels = require("chartjs-plugin-datalabels");
// import { userVisit } from "../charts/total_user_visit_by_category_chart";

var Chart = require("chart.js/dist/Chart.bundle");

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
  new Chart("total_user_feedback", {
    type: "doughnut",
    data: {
      labels: ["😍 Like", "😊 Acceptable", "😞 Dislike"],
      datasets: [
        {
          backgroundColor: ["#1cc88a", "#ffbc00", "#f63e3e"],
          data: [514, 406, 160],
        },
      ],
    },
    options: {
      animation: false, // not relate but should disable
    },
  });
}

function totalVisitChart() {
  new Chart("chart_total_user_visit", {
    type: "doughnut",
    data: {
      labels: ["Owso information", "Ticket tracking", "User feedback"],
      datasets: [
        {
          backgroundColor: ["#E25241", "#75038E", "#12A6A6"],
          data: [4708, 652, 1177],
        },
      ],
    },
    options: {
      animation: false, // not relate but should disable
    },
  });
}
