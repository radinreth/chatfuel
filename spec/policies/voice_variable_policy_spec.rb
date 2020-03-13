require "rails_helper"

RSpec.describe VoiceVariablePolicy do
  subject { described_class.new(user, nil) }

  permissions :update? do
    context "being an ombudsman" do
      let(:user) { build(:user, :ombudsman) }

      it { is_expected.to forbid_action(:update) }
    end

    context "being a site admin" do
      let(:user) { build(:user, :site_admin) }

      it { is_expected.to forbid_action(:update) }
    end

    context "being a system admin" do
      let(:user) { build(:user, :system_admin) }

      it { is_expected.to permit_action(:update) }
    end
  end
end
