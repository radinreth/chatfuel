require "rails_helper"

RSpec.describe UserPolicy do
  subject { described_class.new(user, new_user) }

  let(:resolved_scope) do
    described_class::Scope.new(user, User.all).resolve
  end

  permissions :new? do
    let(:new_user) { build(:user) }

    context "being an site_ombudsman" do
      let(:user) { build(:user, :site_ombudsman) }

      it { is_expected.to forbid_action(:new) }
    end

    context "being a site admin" do
      let(:user) { build(:user, :site_admin) }

      it { is_expected.to permit_action(:new) }
    end

    context "being a system admin" do
      let(:user) { build(:user, :system_admin) }

      it { is_expected.to permit_action(:new) }
    end
  end

  permissions :create? do
    let(:new_user) { build(:user) }

    context "being an site_ombudsman" do
      let(:user) { build(:user, :site_ombudsman) }

      it { is_expected.to forbid_action(:create) }
    end

    context "being a site admin" do
      let(:user) { build(:user, :site_admin) }

      it { is_expected.to permit_action(:create) }

      context "create site_ombudsman" do
        let(:new_user) { build(:user, :site_ombudsman) }

        it { is_expected.to permit_action(:create) }
      end

      context "create site admin" do
        let(:new_user) { build(:user, :site_admin) }

        it { is_expected.to permit_action(:create) }
      end

      context "create system admin" do
        let(:new_user) { build(:user, :system_admin) }

        it { is_expected.to forbid_action(:create) }
      end
    end

    context "being a system admin" do
      let(:user) { build(:user, :system_admin) }

      it { is_expected.to permit_action(:create) }

      context "create site_ombudsman" do
        let(:new_user) { build(:user, :site_ombudsman) }

        it { is_expected.to permit_action(:create) }
      end

      context "create site admin" do
        let(:new_user) { build(:user, :site_admin) }

        it { is_expected.to permit_action(:create) }
      end

      context "create system admin" do
        let(:new_user) { build(:user, :system_admin) }

        it { is_expected.to permit_action(:create) }
      end
    end
  end

  context "#roles" do
    let(:new_user) { nil }

    context "site admin" do
      let(:user) { build(:user, :site_admin) }

      it "excludes system admin" do
        expect(subject.roles).to eq([["site_ombudsman", "site_ombudsman"], ["site_admin", "site_admin"]])
      end
    end

    context "system admin" do
      let(:user) { build(:user, :system_admin) }

      it "returns full roles" do
        expect(subject.roles).to eq({ "site_ombudsman"=>0, "site_admin"=>1, "system_admin"=>2 })
      end
    end
  end

  permissions ".scope" do
    let(:new_user) { create(:user) }

    context "site_ombudsman" do
      let(:user) { build(:user, :site_ombudsman) }

      it "not includes new user" do
        expect(resolved_scope).not_to include(new_user)
      end
    end

    context "site admin" do
      let(:user) { build(:user, :site_admin) }

      it "includes created user" do
        expect(resolved_scope).to include(new_user)
      end
    end

    context "system admin" do
      let(:user) { build(:user, :system_admin) }

      it "includes created user" do
        expect(resolved_scope).to include(new_user)
      end
    end
  end
end
