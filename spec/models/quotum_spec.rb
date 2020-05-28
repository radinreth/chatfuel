# == Schema Information
#
# Table name: quota
#
#  id                 :bigint(8)        not null, primary key
#  on_reach_threshold :string           default("delay")
#  platform_name      :string           default("messenger")
#  secure_zone        :float            default("0.75")
#  threshold          :integer(4)       default("0")
#  total_sent         :integer(4)       default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe Quotum, type: :model do
  it { is_expected.to have_attribute(:on_reach_threshold) }
  it { is_expected.to have_attribute(:platform_name) }
  it { is_expected.to have_attribute(:secure_zone) }
  it { is_expected.to have_attribute(:threshold) }
  it { is_expected.to have_attribute(:total_sent) }

  it { is_expected.to validate_inclusion_of(:on_reach_threshold).in_array(%w(delay drop)) }

  describe "Validation" do
    describe ".ensure_threshold_gte_total_sent" do
      let(:quota) { build(:quotum, total_sent: 2, threshold: 1) }
      it "is invalid when total_sent over threshold" do
        expect(quota).to be_invalid
      end
      it "is valid when total_sent less than threshold" do
        quota.total_sent = 1
        quota.threshold = 2

        expect(quota).to be_valid
      end
    end
  end

  describe "instance methods" do
    let(:quota) { build(:quotum, total_sent: 3, threshold: 5, on_reach_threshold: "drop") }

    it "#remain_size" do
      expect(quota.remain_size).to eq 2
    end

    it "#sentable_size" do
      expect(quota.sentable_size).to eq 2
    end

    it "#drop?" do
      expect(quota.drop?).to be_truthy
    end
  end
end
