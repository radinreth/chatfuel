require "rails_helper"

RSpec.describe Channels::MessengerChannel do
  let(:ticket) { build(:ticket) }
  let(:message) { build(:message, :text) }

  it "calls #send_message one time" do
    expect(subject).to receive(:send_message).with(ticket).once
    subject.send_message(ticket)
  end

  describe "return" do
    before do
      ENV['ENABLE_FB_NOTIFY'] = 'disable'
      allow(ticket).to receive(:message).and_return(nil)
    end

    it "nil" do
      expect(subject.send_message(ticket)).to be_nil
    end
  end

  describe "incomplete ticket" do
    let!(:template) { create(:template, :incomplete) }
    let(:ticket) { build(:ticket, :incomplete) }

    it "#params" do
      allow(ticket).to receive(:message).and_return(message)
      response = {  message: { text: template.content },
                    messaging_type: "MESSAGE_TAG",
                    recipient: { id: message.session_id },
                    tag: "CONFIRMED_EVENT_UPDATE" }

      expect(subject.send(:params, ticket)).to include(response)
    end
  end

  describe "completed ticket" do
    let!(:template) { create(:template, :completed) }
    let(:ticket) { build(:ticket, :completed) }

    it "#params" do
      allow(ticket).to receive(:message).and_return(message)
      response = {  message: { text: template.content },
                    messaging_type: "MESSAGE_TAG",
                    recipient: { id: message.session_id },
                    tag: "CONFIRMED_EVENT_UPDATE" }

      expect(subject.send(:params, ticket)).to include(response)
    end
  end

  describe "incorrect ticket" do
    let!(:template) { create(:template, :incorrect) }

    it "#params" do
      expect(subject.send(:params, nil)).to eq({})
    end
  end
end
