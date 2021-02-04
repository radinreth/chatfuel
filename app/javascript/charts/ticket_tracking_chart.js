import BarChart from './bar_chart'
import { extractBarDataset, m } from '../utils'

class TicketTrackingChart extends BarChart {
  constructor() {
    super();
    this.data = extractBarDataset(gon.ticketTracking);
  }

  chartId = "number_of_ticket_tracking";
  suggestedMax = m( this.data );
  dataset = () => this.data;
}

export const ticketTracking = new TicketTrackingChart();
