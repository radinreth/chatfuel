# == Schema Information
#
# Table name: text_messages
#
#  id                :bigint(8)        not null, primary key
#  first_name        :string
#  gender            :string
#  last_name         :string
#  profile_pic_url   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  messenger_user_id :string           not null
#
require 'rails_helper'

RSpec.describe TextMessage do
  describe 'associations' do
    it { should have_one(:message).dependent(:destroy) }
  end

  it '#type' do
    msg = build(:text_message)

    expect(msg.type).to eq 'Chatbot'
  end

  it 'alias_attribute' do
    msg = build(:text_message, messenger_user_id: 123)

    expect(msg.session_id).to eq msg.messenger_user_id
  end
end
