import GroupBarChart from '../group_bar_chart'

class OverallFeedbackChart extends GroupBarChart {
  chartId = 'chart_overall_rating_by_owso';
  ticksOptions = {
    maxRotation: 45,
    minRotation: 45,
    callback: function(value) {
      let maxLength = 10,
          ellipsisValue = `${value.substr(0, 10)}...`;
      return (value.length >= maxLength) ? ellipsisValue : value;
    }
  }

  format = () => {
    let { labels, dataset } = this.ds;

    return { labels, datasets: _.map(dataset, (el) => el) };
  }
}

export const overallFeedback = new OverallFeedbackChart();
