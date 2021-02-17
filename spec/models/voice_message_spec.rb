# == Schema Information
#
# Table name: voice_messages
#
#  id          :bigint(8)        not null, primary key
#  address     :string
#  called_at   :datetime
#  callsid     :integer(4)
#  finished_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer(4)
#
require "rails_helper"

RSpec.describe VoiceMessage do
  describe 'associations' do
    it { should have_one(:message).dependent(:destroy) }
  end

  it '#type' do
    msg = build(:voice_message)

    expect(msg.type).to eq 'IVR'
  end

  it 'alias_attribute' do
    msg = build(:voice_message, callsid: 123, address: 1234)

    expect(msg.session_id).to eq msg.callsid
  end
end
