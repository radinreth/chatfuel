import { summary } from './summary'
import { infoAccess } from './owso-information-accessed'
import { citizenFeedback } from './citizen-feedback'

OWSO.Charts = {
  render: function() {
    OWSO.Util.chartReg();

    summary.render();
    infoAccess.render();
    citizenFeedback.render();
  }
}
