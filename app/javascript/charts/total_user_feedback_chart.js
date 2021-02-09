import DonutChart from './donut_chart'
import { extractDonutDataset } from '../utils/donut_chart'

class UserFeedback extends DonutChart {
  render = (opts) => {
    let thiz = this;
    $.each( $('.total_user_feedback'), function(_, ele) {
      new Chart($(ele).attr("id"), thiz.config(opts));
    });
  }

  dataset = () => extractDonutDataset(gon.totalUserFeedback);
}

export const userFeedback = new UserFeedback();
