import BaseChart from "./base_chart";

class BarChart extends BaseChart {
  type = "bar";

  _suggestedMax = () => {
    let { data } = this.dataset().datasets[0];
    return this.suggestedMax(data);
  }

  options () {
    return Object.assign({}, this.baseOptions, {
      plugins: {
        datalabels: {
          ...this.baseOptions.plugins.datalabels,
          anchor: "end",
          align: "end",
          color: "#333",
          borderWidth: 0,
          padding: 0,
          backgroundColor: undefined,
          display: true
        }
      },
      cutoutPercentage: 80,
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true,
            suggestedMax: this._suggestedMax(),
          }
        }],
        xAxes: [{
          ticks: {
            maxRotation: 0,
            minRotation: 0,
          }
        }]
      }
    });
  }
}

export default BarChart;
