# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("0")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Template, type: :model do
  it { is_expected.to have_attribute(:content) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to define_enum_for(:status).with_values(incomplete: "0", completed: "1", incorrect: "2").backed_by_column_of_type(:string) }

  it "#platform_value" do
    template = build(:template)

    expect(template.platform_value).to eq 0
  end

  it "#status_value" do
    template = build(:template, status: :completed)

    expect(template.status_value).to eq "1"
  end
end
