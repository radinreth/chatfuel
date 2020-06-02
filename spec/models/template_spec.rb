# == Schema Information
#
# Table name: templates
#
#  id            :bigint(8)        not null, primary key
#  content       :string           default("")
#  platform_name :string           default("0")
#  status        :string           default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe Template, type: :model do
  it { is_expected.to have_attribute(:content) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:platform_name) }
  it { is_expected.to define_enum_for(:platform_name).with_values(messenger: "0", telegram: "1", verboice: "2").backed_by_column_of_type(:string) }

  it "#platform_value" do
    t = build(:template, platform_name: :telegram)

    expect(t.platform_value).to eq "1"
  end
end
