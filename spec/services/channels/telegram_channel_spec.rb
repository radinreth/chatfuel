require "rails_helper"

RSpec.describe Channels::TelegramChannel do
  let(:message) { build(:message, content: build(:text_message, messenger_user_id: 123)) }
  let(:step) { build(:step, message: message) }
  let(:site) { build(:site) }
  let(:ticket) { build(:ticket) }

  before do
    @track = create(:track, step: step, site: site, ticket: ticket)
  end

  describe "invalid" do
    before do
      create(:template, :incomplete)
    end

    it "#params" do
      channel = described_class.new
      response = {
        chat_id: "123",
        disable_notification: true,
        text: "your ticket is incomplete"
      }

      expect(channel.send(:params, ticket)).to eq response
    end

    it "#url" do
      ENV["TELEGRAM_TOKEN"] = "abc"
      channel = described_class.new
      expect(channel.send(:url)).to eq "https://api.telegram.org/botabc/sendMessage"
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
