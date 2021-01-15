import stamp from "../images/stamp.png";

class BaseChart {
  plugins = [chartDataLabels];
  baseOptions = {
    legend: { display: false },
    plugins: {
      datalabels: {
        formatter: Math.round,
        backgroundColor: (context) => context.dataset.backgroundColor,
        borderColor: 'white',
        borderRadius: 100,
        padding: 10,
        borderWidth: 2,
        color: 'white',
        display: false,
        font: {
          family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
          weight: 'bold'
        },
      }
    },
  }

  watermarkOption = {
    watermark: {
      image: stamp,
      x: 0,
      y: 0,
      width: 128,
      height: 128,
      opacity: 0.05,
      alignX: "right",
      alignY: "bottom",
      position: "back",
    }
  }

  render = (opts = {}) => {
    let options = (opts['watermark'] == false) ? this.options : _.extend(this.options, this.watermarkOption);

    new Chart('chart_total_user_visit', {
      type: this.type,
      plugins: this.plugins,
      options: options,
      data: this.dataset()
    });
  };
}

export default BaseChart;
