# == Schema Information
#
# Table name: sites
#
#  id           :bigint(8)        not null, primary key
#  code         :string           default("")
#  name         :string           not null
#  status       :integer(4)       default("0")
#  sync_status  :integer(4)       default("1"), not null
#  token        :string           default("")
#  tracks_count :integer(4)       default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_sites_on_name  (name)
#
require "rails_helper"

RSpec.describe Site, type: :model do
  it { is_expected.to have_attribute(:name) }
  it { is_expected.to have_attribute(:code) }
  it { is_expected.to have_attribute(:status) }
  it { is_expected.to have_attribute(:sync_status) }
  it { is_expected.to define_enum_for(:status).with_values(%i[disable enable]) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:tickets) }
  it { is_expected.to respond_to(:regenerate_token) }

  describe '#before create, generate_token' do
    let(:site) { create(:site, token: nil) }

    it { expect(site.token).not_to be_nil }
  end
end
