import BarChart from './bar_chart'
import { extract } from '../utils'
import { ticksOptions } from '../utils/bar_chart';

class FilteredBarChart extends BarChart {
  ancestor = new BarChart();
  ticksOptions = {}

  dataTitles = (data) => _.map(data.values, el => el.value);
  dataCounts = (data) => _.map(data.values, el => el.count);
  format = (ds) => {
    let data = extract(ds);
    this.ticksOptions = ds.dataset && ds.dataset.length > 4 ? ticksOptions : {};

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
