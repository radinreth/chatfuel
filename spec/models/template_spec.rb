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
  it { is_expected.to have_attribute(:type) }
  it { is_expected.to have_attribute(:content) }
  # it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to define_enum_for(:status).with_values(incomplete: "0", completed: "1", incorrect: "2").backed_by_column_of_type(:string) }

  describe "methods" do
    let(:template) { build(:template) }

    it "#platform_value" do
      expect(template.platform_value).to eq 0
    end

    it "#status_value" do
      template.completed!

      expect(template.status_value).to eq "1"
    end
  end

  describe ".platform_names" do
    it "excludes TelegramTemplate" do
      platform_names = [["Messenger", "MessengerTemplate"], ["Verboice", "VerboiceTemplate"]]

      expect(described_class.platform_names).to eq platform_names
    end

    it "includes TelegramTemplate" do
      ENV['TELEGRAM_ENABLED'] = 'true'
      platform_names = [["Messenger", "MessengerTemplate"], ["Telegram", "TelegramTemplate"], ["Verboice", "VerboiceTemplate"]]

      expect(described_class.platform_names).to eq platform_names
    end
  end

  context 'for' do
    context 'messenger' do
      let!(:template) { create(:template, :messenger) }

      it { expect(Template.for(:incomplete, :messenger)).to be_a(MessengerTemplate) }
    end

    context 'telegram' do
      let!(:template) { create(:template, :telegram) }

      it { expect(Template.for(:incomplete, :telegram)).to be_a(TelegramTemplate) }
    end

    context 'telegram' do
      let!(:template) { create(:template, :verboice) }

      it { expect(Template.for(:incomplete, :verboice)).to be_a(VerboiceTemplate) }
    end
  end

end
