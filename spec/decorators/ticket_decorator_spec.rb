require "rails_helper"

RSpec.describe TicketDecorator do
  let(:ticket) { build(:ticket) }

  before do
    @decorator = described_class.new(ticket)
  end

  it '#delegates' do
    expect(@decorator).to respond_to(:status)
    expect(@decorator).to respond_to(:description)
    expect(@decorator).to respond_to(:code)
    expect(@decorator).to respond_to(:status)
  end
end
