import LineChart from "./line_chart";

class ScatterChart extends LineChart {
  ancestor = new LineChart();

  options = () => {
    return {
      ...this.ancestor.options(),
      legend: { display: false, },
      layout: {
        padding: {
          right: 50
        }
      },
      elements: {
        point: {
          pointStyle: "circle"
        }
      },
      scales: {
        xAxes:[{
          ticks: {
            autoSkip: false,
            maxRotation: 45,
            minRotation: 45,
            callback: function(value) {
              let maxLength = 10,
                  ellipsisValue = `${value.substr(0, 10)}...`;
          
              return (value.length >= maxLength) ? ellipsisValue : value;
            },
          }
        }],
        yAxes: [{
          ticks: {
            suggestedMax: this._suggestedMax(),
          }
        }]
      },
      plugins: {
        datalabels: {
          anchor: "end",
          align: "end",
          rotation: 0,
          textAlign: "center",
          backgroundColor: "#2F3559",
          color: "#FFF",
          font: { size: 10 }
        }
      }
    }
  }
}

export default ScatterChart;
