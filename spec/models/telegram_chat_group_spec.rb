# == Schema Information
#
# Table name: telegram_chat_groups
#
#  id         :bigint(8)        not null, primary key
#  bot_token  :string
#  chat_type  :string           default("group")
#  is_active  :boolean
#  reason     :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :string
#
require "rails_helper"

RSpec.describe TelegramChatGroup, type: :model do
  it { is_expected.to have_many(:site_settings_telegram_chat_groups) }
  it { is_expected.to have_many(:site_settings).through(:site_settings_telegram_chat_groups) }

  describe '.with_current_actived_bot' do
    context 'no bot' do
      let!(:mygroup) { create(:telegram_chat_group) }

      it { expect(TelegramChatGroup.count).to eq(1)  }
      it { expect(TelegramChatGroup.with_current_actived_bot.length).to eq(0) }
    end

    context 'has bot' do
      context 'actived' do
        let!(:bot) { create(:telegram_bot) }
        let!(:mygroup) { create(:telegram_chat_group, bot_token: bot.token) }

        it { expect(TelegramChatGroup.with_current_actived_bot.length).to eq(1) }
      end

      context 'inactived' do
        let!(:bot) { create(:telegram_bot, actived: false) }
        let!(:mygroup) { create(:telegram_chat_group, bot_token: bot.token) }

        it { expect(TelegramChatGroup.with_current_actived_bot.length).to eq(0) }
      end
    end
  end
end
