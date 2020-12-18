import stamp from "../images/stamp.png";

export var initData = {
  datasets: [
    {
      maxBarThickness: 36,
      minBarLength: 2
    }
  ]
}

export var initOptions = { 
  plugins: {
    datalabels: {
      anchor: "end",
      align: "end",
      rotation: 0,
      textAlign: "center",
      formatter: function(value, context) {
        let { dataTitles } = context.dataset

        if( dataTitles == undefined ) return value
        else return dataTitles[context.dataIndex] + "\n" + value;
      }
    }
  },
  legend: {
    display: false
  },
  scales: {
    yAxes: [{
      display: true,
      ticks: {
        beginAtZero: true
      }
    }],
    xAxes: [{
      gridLines: {
        display: false
      },
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
    }]
  },
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
};
