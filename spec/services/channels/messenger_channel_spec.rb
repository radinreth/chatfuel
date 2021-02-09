require "rails_helper"

RSpec.describe Channels::MessengerChannel do
  let(:ticket) { build(:ticket) }
  let(:session) { build(:session) }

  it "calls #send_message one time" do
    expect(subject).to receive(:send_message).with(ticket).once
    subject.send_message(ticket)
  end

  describe "incomplete ticket" do
    let!(:template) { create(:template, :incomplete) }
    let(:ticket) { build(:ticket, :incomplete) }

    it "#params" do
      allow(ticket).to receive(:session).and_return(session)
      response = {  message: { text: template.content },
                    messaging_type: "MESSAGE_TAG",
                    recipient: { id: session.session_id },
                    tag: "CONFIRMED_EVENT_UPDATE" }

      expect(subject.send(:params, ticket)).to include(response)
    end
  end

  describe "completed ticket" do
    let!(:template) { create(:template, :completed) }
    let(:ticket) { build(:ticket, :completed) }

    it "#params" do
      allow(ticket).to receive(:session).and_return(session)
      response = {  message: { text: template.content },
                    messaging_type: "MESSAGE_TAG",
                    recipient: { id: session.session_id },
                    tag: "CONFIRMED_EVENT_UPDATE" }

      expect(subject.send(:params, ticket)).to include(response)
    end
  end
end
