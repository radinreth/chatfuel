import LineChart from "./line_chart";

class ScatterChart extends LineChart {
  ancestor = new LineChart();
  scatterOption = {
    fill: false,
    pointRadius: 5,
    pointHoverRadius: 10,
    showLine: false
  }

  options = () => {
    return {
      ...this.ancestor.options(),
      legend: {
        display: false,
      },
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
              var maxLength = 10;
              if( value.length >= maxLength ) {
                return `${value.substr(0, 10)}...`;
              } else {
                return value;
              }
            },
          }
        }],
        yAxes: [{
          ticks: {
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
          font: {
            size: 10
          }
        }
      }
    }
  }
}

export default ScatterChart;
