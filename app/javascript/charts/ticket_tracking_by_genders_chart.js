import { doughnutData, doughnutConfig } from '../data/doughnutchart/defaults'

export const ticketTrackingByGenders = () => {
  new Chart('chart_ticket_tracking_by_gender', {
    ...doughnutConfig,
    data: doughnutData(gon.ticketTrackingByGenders)
  });
}
