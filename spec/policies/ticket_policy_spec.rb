require "rails_helper"

RSpec.describe TicketPolicy do
  subject { described_class.new(user, ticket) }

  let(:ticket) { create(:ticket) }

  let(:resolved_scope) do
    described_class::Scope.new(user, Ticket.all).resolve
  end

  context "being a ombudsman" do
    let(:user) { build(:user, :site_ombudsman) }

    it { is_expected.to forbid_actions(%i[index new edit create update destroy]) }
  end

  context "being a system admin" do
    let(:user) { build(:user, :system_admin) }

    it { is_expected.to permit_actions(%i[index new edit create update destroy]) }
  end
end
