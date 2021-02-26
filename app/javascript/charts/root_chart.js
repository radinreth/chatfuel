import { infoAccess } from './owso-information-accessed';
import { feedback } from './citizen-feedback';
import { dashboard } from './private-dashboard';

export const renderChart = function () {
  OWSO.Util.chartReg();

  infoAccess.renderCharts();
  feedback.renderCharts();
  dashboard.renderCharts();
}
