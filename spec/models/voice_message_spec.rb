RSpec.describe VoiceMessage do
  describe 'associations' do
    it { should have_one(:message).dependent(:destroy) }
    it { should have_many(:steps).through(:message) }
  end

  it '#type' do
    msg = build(:voice_message)

    expect(msg.type).to eq 'IVR'
  end

  it 'alias_attribute' do
    msg = build(:voice_message, CallSid: 123)

    expect(msg.session_id).to eq msg.CallSid
  end
end
