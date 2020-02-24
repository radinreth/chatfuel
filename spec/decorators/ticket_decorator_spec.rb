RSpec.describe TicketDecorator do
  context ':submitted' do
    it 'is a kind of SubmittedStatus' do
      ticket = create(:ticket, status: :submitted)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(SubmittedStatus)
    end
  end

  context ':completed' do
    it 'is a kind of CompletedStatus' do
      ticket = create(:ticket, status: :completed)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(CompletedStatus)
    end
  end

  context ':picked_up' do
    it 'is a kind of PickedUpStatus' do
      ticket = create(:ticket, status: :picked_up)

      @decorator = described_class.new(ticket)

      expect(@decorator.send(:klazz)).to be_a_kind_of(PickedUpStatus)
    end
  end
end
