require "rails_helper"

RSpec.describe Channels::BaseChannel do
  
  let(:message) { build(:message, :text) }
  let(:step) { build(:step, message: message) }
  let(:site) { build(:site) }
  let(:ticket) { build(:ticket) }
  let(:template) { build(:template) }

  before do
    @track = create(:track, step: step, site: site, ticket: ticket)
  end

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
    create(:template)
    template = subject.send(:response_template, ticket)

    expect(template).to be_kind_of(Template)
  end
end
