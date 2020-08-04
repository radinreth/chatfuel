require "rails_helper"

RSpec.describe Channels::MessengerChannel do
  let!(:message) { create(:message, content: create(:text_message, messenger_user_id: 123)) }
  let!(:site)    { create(:site) }
  let!(:ticket)  { create(:ticket, :incomplete) }
  let!(:template)       { create(:template, :incomplete, :messenger)}
  let!(:variable_value) { create(:variable_value, raw_value: ticket.code) }
  let!(:step_value)     { create(:step_value, message: message, variable_value: variable_value)}
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

  
  
  # describe "" do
  #   let(:message) { build(:message) }

  #   before do
  #     ENV['ENABLE_FB_NOTIFY'] = 'enable'
  #     allow(ticket).to receive(:message).and_return(message)
  #   end

  #   it '' do
  #     expect(subject.send_message(ticket)).not_to be_nil
  #   end
  # end

  
  
  # let(:ticket) { build(:ticket, :incomplete) }

  before do
    @track = create(:track, site: site, ticket: ticket)
  end

  describe "invalid" do
    it "#params" do
      channel = described_class.new
      response = {
          message: {
            text: "your ticket is incomplete"
          },
        messaging_type: "MESSAGE_TAG",
        recipient: { id: message.session_id },
        tag: "CONFIRMED_EVENT_UPDATE"
      }

  #     expect(channel.send(:params, ticket)).to eq response
  #   end

  #   it "respond_to?" do
  #     channel = described_class.new
  #     expect(channel.respond_to?(:send_message)).to be_truthy
  #   end

  #   it "#send_message" do
  #     expect(subject).to receive(:send_message).with(ticket)
  #     subject.send_message(ticket)
  #   end
  # end
end
