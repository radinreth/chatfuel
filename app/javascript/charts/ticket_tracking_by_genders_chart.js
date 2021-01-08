import { donutData, donutConfig } from '../data/donutchart/defaults'

export const ticketTrackingByGenders = () => {
  new Chart('chart_ticket_tracking_by_gender', {
    ...donutConfig,
    data: donutData(gon.ticketTrackingByGenders)
  });
}
