require "rails_helper"

RSpec.describe Channels::TelegramChannel do
  let(:ticket) { build(:ticket) }
  let(:message) { build(:message, :text) }

  it "calls #send_message one time" do
    expect(subject).to receive(:send_message).with(ticket).once
    subject.send_message(ticket)
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
