import ScatterChart from '../scatter_chart'
import { extract } from '../../utils'
import { suggestedMax } from '../../utils/bar_chart'

class MainServiceAccessChart extends ScatterChart {
  chartId = "chart_number_access_by_main_services";
  ancestor = new ScatterChart();
  
  dataset = () => this.format();
  options = () => {
    let { max } = this.splat()
    let options = Object.assign({}, this.ancestor.options())
    options.scales.yAxes[0].ticks.suggestedMax = max;
    return options
  }

  splat = () => {
    let { colors, labels, values } = extract(gon.accessMainService);
    return { colors, labels, values, max: suggestedMax(values) }
  }

  format = () => {
    let { colors, labels, values } = this.splat();

    return {  labels: labels,
              datasets: [
                { ...this.ancestor.scatterOption,
                  backgroundColor: colors,
                  data: values }
              ]};
  }
}

export const mainServiceAccess = new MainServiceAccessChart();
