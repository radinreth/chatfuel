import { donutData, donutConfig } from '../data/donutchart/defaults'

export const genderInfo = () => {
  OWSO.Util.createOrUpdate('chart_information_access_by_gender', {
    ...donutConfig,
    data: donutData(gon.genderInfo)
  });
}
