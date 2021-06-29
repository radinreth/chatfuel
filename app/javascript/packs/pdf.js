// window.chartDataLabels = require("chartjs-plugin-datalabels");
// import { userVisit } from "../charts/total_user_visit_by_category_chart";

var Chart = require("chart.js/dist/Chart.bundle");

$(document).ready(function () {
  try {
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
    // userVisit.render();
  } catch (e) {
    $(".test-content").html(e.message);
  }
});
