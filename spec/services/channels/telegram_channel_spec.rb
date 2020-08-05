require "rails_helper"

RSpec.describe Channels::TelegramChannel do
  let(:ticket) { build(:ticket) }
  let(:message) { build(:message, :text) }

  it "calls #send_message one time" do
    expect(subject).to receive(:send_message).with(ticket).once
    subject.send_message(ticket)
  end

  describe "return" do
    before do
      ENV['ENABLE_TG_NOTIFY'] = 'disable'
      allow(ticket).to receive(:message).and_return(nil)
    end

    it "nil" do
      expect(subject.send_message(ticket)).to be_nil
    end
  end

  describe "incomplete ticket" do
    let!(:template) { create(:template, :telegram, :incomplete) }
    let(:ticket) { build(:ticket, :incomplete) }

    it "#params" do
      allow(ticket).to receive(:message).and_return(message)
      response = {  chat_id: message.session_id,
                    text: template.content,
                    disable_notification: true }

      expect(subject.send(:params, ticket)).to include(response)
    end
  end

  describe "completed ticket" do
    let!(:template) { create(:template, :telegram, :completed) }
    let(:ticket) { build(:ticket, :completed) }

    it "#params" do
      allow(ticket).to receive(:message).and_return(message)
      response = {  chat_id: message.session_id,
                    text: template.content,
                    disable_notification: true }

      expect(subject.send(:params, ticket)).to include(response)
    end
  end
end
