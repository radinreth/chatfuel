import { sum } from '../utils/array'
import DonutChart from './donut_chart'

class UserGender extends DonutChart {
  chartId = "total_user_gender";

  dataset = () => {
    let { colors, dataset } = gon.totalUserByGender;
    let [labels, values] = [_.keys(dataset), _.values(dataset)];

    return {
      labels: labels,
      total: sum(values),
      datasets: [
        {
          backgroundColor: colors,
          data: values,
        }
      ]
    };
  }
}

export const userGender = new UserGender();
