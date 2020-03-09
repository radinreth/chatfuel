require "rails_helper"

RSpec.describe SitePolicy do
  subject { described_class.new(user, site) }

  let(:site) { build(:site) }

  context "being a ombudsman" do
    let(:user) { build(:user, :ombudsman) }

    it { is_expected.to forbid_actions(%i[index]) }
  end

  context "being a site_admin" do
    let(:user) { build(:user, :site_admin) }

    it { is_expected.to forbid_actions(%i[index]) }
  end

  context "being a system_admin" do
    let(:user) { build(:user, :system_admin) }

    it { is_expected.to permit_action(:index) }
  end
end
