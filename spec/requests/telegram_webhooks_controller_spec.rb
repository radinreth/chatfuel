require "rails_helper"
require 'telegram/bot/rspec/integration/rails'

RSpec.describe TelegramWebhooksController, telegram_bot: :rails do
  let(:chat_group) { TelegramChatGroup.first }

  context 'create a new group with bot as a member' do
    let(:group_chat_created_param) {
      {
        "from"=>{"id"=>787037629, "is_bot"=>false, "first_name"=>"Sokly", "last_name"=>"Heng", "language_code"=>"en"},
        "chat"=>{"id"=>-446769548, "title"=>"mygroup", "type"=>"group", "all_members_are_administrators"=>true},
        "date"=>1598321385,
        "group_chat_created"=>true
      }
    }

    before {
      dispatch_message('', group_chat_created_param)
    }

    it { expect(TelegramChatGroup.count).to eq(1) }
    it { expect(chat_group.is_active).to eq(true) }
    it { expect(chat_group.title).to eq('mygroup') }
    it { expect(chat_group.chat_type).to eq('group') }
  end

  context 'add bot to group' do
    let(:new_chat_member_param) {
      {
        "from"=>{"id"=>123, "is_bot"=>false, "first_name"=>"Sokly", "last_name"=>"Heng", "language_code"=>"en"},
        "chat"=>{"id"=>-1001416771311, "title"=>"mygroup", "type"=>"supergroup"},
        "new_chat_member"=>{"id"=>952424300, "is_bot"=>true, "first_name"=>"ebs_bot", "username"=>"ebs_system_bot"}
      }
    }

    before {
      dispatch_message('', new_chat_member_param)
    }

    it { expect(TelegramChatGroup.count).to eq(1) }
    it { expect(chat_group.is_active).to eq(true) }
    it { expect(chat_group.title).to eq('mygroup') }
    it { expect(chat_group.chat_type).to eq('supergroup') }
  end

  context 'remove bot from group' do
    let(:left_chat_member_param) {
      {
        "from"=>{"id"=>123, "is_bot"=>false, "first_name"=>"Sokly", "last_name"=>"Heng", "language_code"=>"en"},
        "chat"=>{"id"=>111, "title"=>"mygroup", "type"=>"group"},
        "left_chat_member"=>{"id"=>952424300, "is_bot"=>true, "first_name"=>"ebs_bot", "username"=>"ebs_system_bot"}
      }
    }

    let!(:mygroup) { create(:telegram_chat_group) }

    before {
      dispatch_message('', left_chat_member_param)
    }

    it { expect(TelegramChatGroup.count).to eq(1) }
    it { expect(chat_group.is_active).to eq(false) }
    it { expect(chat_group.title).to eq('mygroup') }
    it { expect(chat_group.chat_type).to eq('group') }
  end

  context 'migrate to supergroup' do
    let(:migrate_to_chat_param) {
      {
        "from"=>{"id"=>787037629, "is_bot"=>false, "first_name"=>"Sokly", "last_name"=>"Heng"},
        "chat"=>{"id"=>111, "title"=>"test-group3", "type"=>"group", "all_members_are_administrators"=>false},
        "migrate_to_chat_id"=>-1001441058136
      }
    }

    before {
      create(:telegram_chat_group)
      dispatch_message('', migrate_to_chat_param)
    }

    it { expect(TelegramChatGroup.count).to eq(1) }
    it { expect(chat_group.chat_id).to eq('-1001441058136') }
    it { expect(chat_group.chat_type).to eq('supergroup') }
  end

  describe 'bot_token' do
    let(:new_chat_member_param) {
      {
        "from"=>{"id"=>123, "is_bot"=>false, "first_name"=>"Sokly", "last_name"=>"Heng", "language_code"=>"en"},
        "chat"=>{"id"=>'111', "title"=>"mygroup", "type"=>"supergroup"},
        "new_chat_member"=>{"id"=>952424300, "is_bot"=>true, "first_name"=>"ebs_bot", "username"=>"ebs_system_bot"}
      }
    }

    context 'no telegram_bot' do
      before {
        dispatch_message('', new_chat_member_param)
      }

      it { expect(chat_group.bot_token).to be_nil }
    end

    context 'has telegram_bot' do
      context 'bot actived' do
        let!(:bot) { create(:telegram_bot) }

        before {
          dispatch_message('', new_chat_member_param)
        }

        it { expect(chat_group.bot_token).to eq(bot.token) }
      end

      context 'bot not actived' do
        let!(:bot) { create(:telegram_bot, actived: false) }

        before {
          dispatch_message('', new_chat_member_param)
        }

        it { expect(chat_group.bot_token).to be_nil }
      end
    end

    context 'bot_token exist' do
      let!(:mygroup) { create(:telegram_chat_group, bot_token: '456:abc', is_active: false) }
      let!(:bot) { create(:telegram_bot) }

      before {
        dispatch_message('', new_chat_member_param)
      }

      it { expect(chat_group.is_active).to eq(true) }
      it { expect(chat_group.bot_token).to eq('456:abc') }
    end
  end
end
