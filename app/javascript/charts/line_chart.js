import BaseChart from "./base_chart";

class LineChart extends BaseChart {
  type = "line";

  options () {
    let { plugins } = this.baseOptions

    return Object.assign({}, this.baseOptions, {
      legend: {
        display: true
      },
      plugins: {
        datalabels: {
          ...plugins.datalabels,
        }
      },
      scales: {
        xAxes: [{
          ticks: {
            display: true,
            autoSkip: true,
            maxRotation: 0,
            minRotation: 0,
            maxTicksLimit: 6,
          }
        }]
      }
    });
  }
}

export default LineChart;
