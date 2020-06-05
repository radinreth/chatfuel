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
    expect(@decorator).to respond_to(:incomplete_at)
    expect(@decorator).to respond_to(:completed_at)
    expect(@decorator).to respond_to(:incorrect_at)
  end

  context ':incomplete' do
    it 'is a kind of IncompleteStatus' do
      ticket = build(:ticket, status: :incomplete)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(IncompleteStatus)
    end
  end

  context ':completed' do
    it 'is a kind of CompletedStatus' do
      ticket = build(:ticket, status: :completed)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(CompletedStatus)
    end
  end

  context ':incorrect' do
    it 'is a kind of IncorrectStatus' do
      ticket = build(:ticket, status: :incorrect)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(IncorrectStatus)
    end
  end
end
