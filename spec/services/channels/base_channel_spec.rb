require "rails_helper"

RSpec.describe Channels::BaseChannel do
  let!(:template) { create(:template) }
  let!(:ticket) { build(:ticket, :incomplete) }
  let!(:message) { build(:message, :text) }
  let!(:variable_value) { build(:variable_value, raw_value: ticket.code) }
  let!(:step_value) { create(:step_value, message: message, variable_value: variable_value)}

  it ".get" do
    channel = described_class.get(ticket.platform_name)
    expect(channel).to be_kind_of(Channels::MessengerChannel)
  end

  it "#send_message" do
    channel = described_class.new
    expect { channel.send_message(ticket) }.to raise_error(RuntimeError, "you have to implement in subclass")
  end

  it "#text_message" do
    content = subject.send(:text_message, template)

    expect(content).to eq template.content
  end

  it "#response_template" do
    template = subject.send(:response_template, ticket)

    expect(template).to be_kind_of(Template)
  end
end
