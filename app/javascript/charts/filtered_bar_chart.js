import BarChart from './bar_chart'
import { extract } from '../utils'

class FilteredBarChart extends BarChart {
  ancestor = new BarChart();
  ticksOptions = {
    maxRotation: 45,
    minRotation: 45,
    callback: function(value) {
      let maxLength = 10,
          ellipsisValue = `${value.substr(0, 10)}...`;
      return (value.length >= maxLength) ? ellipsisValue : value;
    }
  }

  dataTitles = (data) => _.map(data.values, el => el.value);
  dataCounts = (data) => _.map(data.values, el => el.count);
  format = (ds) => {
    let data = extract(ds);
    return {  labels: _.keys(ds.dataset),
              datasets: [
                { ...this.ancestor.dataFormat(),
                  backgroundColor: data.colors,
                  dataTitles: this.dataTitles(data),
                  data: this.dataCounts(data) }
              ]
            };
  }
}

export default FilteredBarChart
