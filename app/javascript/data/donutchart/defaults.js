import { sum } from '../../utils/array'
import { initOptions } from '../../data/defaults'

let mapLabel = (chart, label, i) => {
  let meta = chart.getDatasetMeta(0);
  let ds = chart.data.datasets[0];
  let arc = meta.data[i];
  let custom = arc && arc.custom || {};
  let getValueAtIndexOrDefault = Chart.helpers.getValueAtIndexOrDefault;
  let arcOpts = chart.options.elements.arc;
  let fill = custom.backgroundColor ? custom.backgroundColor : getValueAtIndexOrDefault(ds.backgroundColor, i, arcOpts.backgroundColor);
  let stroke = custom.borderColor ? custom.borderColor : getValueAtIndexOrDefault(ds.borderColor, i, arcOpts.borderColor);
  let bw = custom.borderWidth ? custom.borderWidth : getValueAtIndexOrDefault(ds.borderWidth, i, arcOpts.borderWidth);

  return {
    text: label,
    fillStyle: fill,
    strokeStyle: stroke,
    lineWidth: bw,
    hidden: isNaN(ds.data[i]) || meta.data[i].hidden,
    index: i
  }
}

export const generateLabels = function(chart) {
  let data = chart.data
  return _.map(data.labels, mapLabel.bind(null, chart))
}

const options = {
  layout: {
    padding: {
      top: 15,
    }
  },
  legend: {
    position: "left",
    labels: {
      boxWidth: 12,
      generateLabels: generateLabels
    }
  },
  cutoutPercentage: 80,
  watermark: {
    ...initOptions.watermark,
    position: "front"
  },
  plugins: {
    datalabels: {
      backgroundColor: function(context) {
        return context.dataset.backgroundColor;
      },
      anchor: "end",
      borderColor: 'white',
      padding: function(context) {
        var index = context.dataIndex;
        var value = context.dataset.data[index];
        return value < 10 ? { left: 6, right: 6, top: 3, bottom: 3 } : 5;
      },
      borderRadius: 100,
      borderWidth: 1,
      color: 'white',
      display: true,
      font: {
        family: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
      },
      formatter: Math.round
    }
  }
}

export const donutData = function(data) {
  let { colors, dataset } = data;
  let [labels, values] = [_.keys(dataset), _.values(dataset)];

  return  {
    labels: labels,
    total: sum(values),
    datasets: [
      { backgroundColor: colors, data: values }
    ]
  };
}

export const donutConfig = {
  type: 'doughnut', 
  plugins: [chartDataLabels],
  options: options,
}

export const labels = {
  boxWidth: 12,
  usePointStyle: false,
  generateLabels: generateLabels
}
