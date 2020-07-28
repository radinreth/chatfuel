require "rails_helper"

RSpec.describe Channels::TelegramChannel do
  let!(:message) { create(:message, platform_name: 'Telegram', content: build(:text_message, messenger_user_id: 123)) }
  let!(:site)    { create(:site) }
  let!(:ticket)  { create(:ticket, :incomplete) }
  let!(:template)       { create(:template, :incomplete, :telegram)}
  let!(:variable_value) { create(:variable_value, raw_value: ticket.code) }
  let!(:step_value)     { create(:step_value, message: message, variable_value: variable_value)}

  describe "invalid" do
    it "#params" do
      channel = described_class.new
      response = {
        chat_id: "123",
        disable_notification: true,
        text: "your ticket is incomplete"
      }

      expect(channel.send(:params, ticket)).to eq response
    end

    it "respond_to?" do
      channel = described_class.new
      expect(channel.respond_to?(:send_message)).to be_truthy
    end

    it "#send_message" do
      expect(subject).to receive(:send_message).with(ticket)
      subject.send_message(ticket)
    end
  end
end
