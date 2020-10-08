require 'rails_helper'

RSpec.describe DashboardQuery.new do
  let(:variable) { build(:variable) }

  it "#most_requested_service" do
    expect(Variable).to receive(:most_request).and_return(variable)
    expect(variable).to receive(:agg_values_count).and_return({ 2 => 2, 1 => 1 })
    expect(variable).to receive(:transform_key_result).and_return({ key: "value_name", value: 2 })

    subject.most_requested_service
  end
end
