import { sum } from '../utils/array'

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
  let perc = parseFloat(ds.data[i] / chart.data.total*100).toFixed(2)

  return {
    text: `${label} (${perc}%)`,
    fillStyle: fill,
    strokeStyle: stroke,
    lineWidth: bw,
    hidden: isNaN(ds.data[i]) || meta.data[i].hidden,
    index: i
  }
}

let generateLabels = function(chart) {
  let data = chart.data
  return _.map(data.labels, mapLabel.bind(null, chart))
}

export const GenderInfoChart = (ctx) => {
  let type = 'pie', 
      plugins = [chartDataLabels];

  let { colors, dataset } = gon.genderInfo;
  let [genderLabels, values] = [_.keys(dataset), _.values(dataset)];

  let data = {
    labels: genderLabels,
    total: sum(values),
    datasets: [
      {
        backgroundColor: colors,
        data: values,
      }
    ]
  };

  let options = {
    legend: {
      position: "left",
      labels: {
        boxWidth: 12,
        generateLabels: generateLabels
      }
    },
    plugins: {
      datalabels: {
        color: "#333"
      }
    }
  };

  console.log("data: ", data)
  console.log("options: ", options)

  return new Chart(ctx, { type, plugins, data, options });
}