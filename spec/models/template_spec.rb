# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Template, type: :model do
  it { is_expected.to have_attribute(:content) }
  it { is_expected.to validate_presence_of(:content) }

  describe "one template" do
    before { create(:template) }

    it "does not create template" do
      expect {
        create(:template)
      }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: multiple templates is not allowed")
    end
  end
end
