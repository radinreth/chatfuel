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

    %w(invalid 34348 *$## INVALID _invalid_).each do |invalid|
      it "InvalidChannel" do
        expect(described_class.get(invalid)).to be_a(Channels::InvalidChannel)
      end
    end
  end

  it "raise" do
    expect { subject.send_message(ticket) }.to raise_error(RuntimeError, "you have to implement in subclass")
  end

  # let!(:template) { create(:template) }

  # let(:ticket) { build(:ticket, :incomplete) }
  # let(:message) { build(:message, :text) }
  # let(:tracking_variable) { build(:variable, :tracking) }
  # let(:variable_value) { build(:variable_value, raw_value: ticket.code, variable: tracking_variable) }
  # let!(:message_step) { create(:step, value: variable_value, message: message) }

  # it ".get" do
  #   channel = described_class.get(ticket.platform_name)
  #   expect(channel).to be_kind_of(Channels::MessengerChannel)
  # end

  # it "#send_message" do
  #   channel = described_class.new
  #   expect { channel.send_message(ticket) }.to raise_error(RuntimeError, "you have to implement in subclass")
  # end

  # it "#text_message" do
  #   content = subject.send(:text_message, template)

  #   expect(content).to eq template.content
  # end

  # it "#response_template" do
  #   template = subject.send(:response_template, ticket)

  #   expect(template).to be_kind_of(Template)
  # end
end
