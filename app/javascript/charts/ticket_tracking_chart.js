import BarChart from './bar_chart'
import { extractBarDataset, suggestedMax } from '../utils/bar_chart'

class TicketTrackingChart extends BarChart {
  chartId = "number_of_ticket_tracking";

  suggestedMax = (data) => suggestedMax(data);
  dataset = () => extractBarDataset(gon.ticketTracking);
}

export const ticketTracking = new TicketTrackingChart();
