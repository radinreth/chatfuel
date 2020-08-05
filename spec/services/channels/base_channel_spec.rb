require "rails_helper"

RSpec.describe Channels::BaseChannel do
  let(:ticket) { build(:ticket) }

  describe ".get" do
    it "MessengerChannel" do
      expect(described_class.get("Messenger")).to be_a(Channels::MessengerChannel)
    end

    it "MessengerChannel" do
      expect(described_class.get("Telegram")).to be_a(Channels::TelegramChannel)
    end

    %w(invalid Line WhatApp INVALID _invalid_).each do |invalid|
      it "InvalidChannel" do
        expect(described_class.get(invalid)).to be_a(Channels::InvalidChannel)
      end
    end
  end

  it "raise" do
    expect { subject.send_message(ticket) }.to raise_error(RuntimeError, "you have to implement in subclass")
  end
end
