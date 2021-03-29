import { summary, init as summaryInit } from './summary'
import { infoAccess } from './owso-information-accessed'
import { citizenFeedback } from './citizen-feedback'

import { canvasLoading } from './canvasLoading'

OWSO.Charts = {
  render: function() {
    OWSO.Util.chartReg();

    summary.render();
    infoAccess.render();
    citizenFeedback.render();
  },
  init: () => {
    canvasLoading($("canvas"));
    summaryInit();
  }
}
