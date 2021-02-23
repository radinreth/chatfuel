import BarChart from './bar_chart'
import { extract } from '../utils'
import { suggestedMax } from '../utils/bar_chart'

class MostRequest extends BarChart {
  ancestor = new BarChart();
  chartId = 'chart_most_requested_services';

  suggestedMax = (data) => suggestedMax(data, 1.5);
  dataset = () => this.format(gon.mostRequest);
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

export const mostRequest = new MostRequest();
