require 'rails_helper'

RSpec.describe DashboardQuery.new do
  context "with most request" do
    let(:variable) { build(:variable) }

    before do
      allow(Variable).to receive(:most_request).and_return(variable)
      allow(variable).to receive(:agg_value_count).and_return({ 2 => 2, 1 => 1 })
    end

    it "#most_requested_service" do
      expect(variable).to receive(:transform_key_result).and_return({ key: "value_name", value: 2 })

      subject.most_requested_service
    end
  end
end
