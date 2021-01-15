import { sum } from '../utils/array'
import DonutChart from './donut_chart'

class UserFeedback extends DonutChart {
  render = (opts) => {
    let thiz = this;
    $.each( $('.total_user_feedback'), function(_, ele) {
      new Chart($(ele).attr("id"), thiz.config(opts));
    });
  }

  dataset = () => {
    let { colors, dataset } = gon.totalUserFeedback;
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

export const userFeedback = new UserFeedback();
