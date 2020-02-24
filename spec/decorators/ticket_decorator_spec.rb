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
    expect(@decorator).to respond_to(:submitted_at)
    expect(@decorator).to respond_to(:completed_at)
    expect(@decorator).to respond_to(:picked_up_at)
  end

  context ':submitted' do
    it 'is a kind of SubmittedStatus' do
      ticket = build(:ticket, status: :submitted)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(SubmittedStatus)
    end
  end

  context ':completed' do
    it 'is a kind of CompletedStatus' do
      ticket = build(:ticket, status: :completed)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(CompletedStatus)
    end
  end

  context ':picked_up' do
    it 'is a kind of PickedUpStatus' do
      ticket = build(:ticket, status: :picked_up)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(PickedUpStatus)
    end
  end
end
