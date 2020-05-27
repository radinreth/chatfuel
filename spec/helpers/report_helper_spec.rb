require 'rails_helper'

RSpec.describe ReportHelper do
  let(:content) { build(:text_message) }
  let(:message) { build(:message, content: content) }
  let(:period) { Period.new("28/02/2020 - 28/02/2020") }
  let(:steps) { StepCollectionDecorator.new :accessed, period }

  before do
    # create(:step, act: "owso_options", message: message)
    create(:step, :accessed)
  end

  it "#chart_data" do
    chart_data = chart_data([steps])

    expect(chart_data[0][:name]).to eq "Accessed"
    expect(chart_data[0][:data].values).to eq [1]
  end
end
