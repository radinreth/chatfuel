require "rails_helper"

RSpec.describe Quarterly do
  let(:q1_months) { ["Jan", "Feb", "Mar"] }
  let(:q2_months) { ["Apr", "May", "Jun"] }
  let(:q3_months) { ["Jul", "Aug", "Sep"] }
  let(:q4_months) { ["Oct", "Nov", "Dec"] }

  it "is in quarter 1" do
    q1_months.each do |m|
      q = Quarterly.new(m)
      expect(q.to_quarter).to eq 1
    end
  end

  it "is in quarter 2" do
    q2_months.each do |m|
      q = Quarterly.new(m)
      expect(q.to_quarter).to eq 2
    end
  end

  it "is in quarter 3" do
    q3_months.each do |m|
      q = Quarterly.new(m)
      expect(q.to_quarter).to eq 3
    end
  end

  it "is in quarter 4" do
    q4_months.each do |m|
      q = Quarterly.new(m)
      expect(q.to_quarter).to eq 4
    end
  end

end
