// OWSO Information Accessed
import { mostRequestServiceAccess } from './most_request_service_access_chart';
import { informationAccess } from './access_info_chart';
import { mainServiceAccess } from './access_main_service_chart';
import { mostPopularAccess } from './most_tracked_periodic_chart';
import { ticketTrackingAccess } from './ticket_tracking_by_genders_chart';

export const infoAccess = {
  instances: [
    mostRequestServiceAccess,
    informationAccess,
    mainServiceAccess,
    mostPopularAccess,
    ticketTrackingAccess
  ],
  renderCharts: function() {
    _.each(this.instances, instance => instance.render());
  }
}
