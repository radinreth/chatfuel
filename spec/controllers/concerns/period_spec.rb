require_relative '../../../app/controllers/concerns/period'

RSpec.describe Period do
  context '#name' do
    it ':hour' do
      @period = Period.new '27/02/2020 - 28/02/2020'

      expect(@period.duration_in_day).to be <= 1
      expect(@period.name).to eq(:hour)
    end

    it ':day' do
      @period = Period.new '26/02/2020 - 28/02/2020'

      expect(@period.duration_in_day).to be <= 7
      expect(@period.name).to eq(:day)
    end

    it ':week' do
      @period = Period.new '26/11/2019 - 28/02/2020'

      expect(@period.duration_in_day).to be <= 180
      expect(@period.name).to eq(:week)
    end

    it ':month' do
      @period = Period.new '26/05/2019 - 28/02/2020'

      expect(@period.duration_in_day).to be <= 365
      expect(@period.name).to eq(:month)
    end
  end

  it '#date_range' do
    @period = Period.new '26/05/2019 - 28/02/2020'

    start_date = Time.parse('26/05/2019')
    end_date = Time.parse('28/02/2020')

    expect(@period.date_range).to eq [start_date, end_date]
  end
end
