import BarChart from './bar_chart'
import { extract } from '../utils'

class FilteredBarChart extends BarChart {
  ancestor = new BarChart();

  dataTitles = (data) => _.map(data.values, el => el.value);
  dataCounts = (data) => _.map(data.values, el => el.count);
  format = (ds) => {
    let data = extract(ds);
    return {  labels: _.keys(ds.dataset),
              datasets: [
                { ...this.ancestor.dataFormat(),
                  backgroundColor: data.colors,
                  dataTitles: this.dataTitles(data),
                  maxBarThickness: 50,
                  data: this.dataCounts(data) }
              ]
            };
  }
}

export default FilteredBarChart
