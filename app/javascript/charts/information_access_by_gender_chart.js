import { donutData, donutConfig } from '../data/donutchart/defaults'

export const genderInfo = () => {
  new Chart('chart_information_access_by_gender', {
    ...donutConfig,
    data: donutData(gon.genderInfo)
  });
}
