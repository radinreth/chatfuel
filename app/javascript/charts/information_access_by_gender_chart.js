import { doughnutData, doughnutConfig } from '../data/doughnutchart/defaults'

export const genderInfo = () => {
  new Chart('chart_information_access_by_gender', {
    ...doughnutConfig,
    data: doughnutData(gon.genderInfo) 
  });
}
