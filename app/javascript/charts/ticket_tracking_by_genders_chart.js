import { donutData, donutConfig } from '../data/donutchart/defaults'

export const ticketTrackingByGenders = () => {
  OWSO.Util.createOrUpdate('chart_ticket_tracking_by_gender', {
    ...donutConfig,
    data: donutData(gon.ticketTrackingByGenders)
  });
}
