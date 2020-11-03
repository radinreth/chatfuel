require "rails_helper"

RSpec.describe Filters::ProvinceFilter do
  let(:province) { described_class.new "02" }

  it "#name" do
    expect(province.name).to eq "Battambang"
  end
end
