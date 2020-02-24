RSpec.describe TicketDecorator do
  let(:ticket) { build(:ticket, status: :submitted) }

  context ':submitted' do
    let(:ticket) { create(:ticket, status: :submitted) }

    before do
      @decorator = described_class.new(ticket)
    end

    it 'is a kind of SubmittedStatus' do
      expect(@decorator.send(:klazz)).to be_a_kind_of(SubmittedStatus)
    end
  end

  context ':completed' do
    let(:ticket) { create(:ticket, status: :completed) }

    before do
      @decorator = described_class.new(ticket)
    end

    it 'is a kind of CompletedStatus' do
      expect(@decorator.send(:klazz)).to be_a_kind_of(CompletedStatus)
    end
  end

  context ':picked_up' do
    let(:ticket) { create(:ticket, status: :picked_up) }

    before do
      @decorator = described_class.new(ticket)
    end

    it 'is a kind of PickedUpStatus' do
      expect(@decorator.send(:klazz)).to be_a_kind_of(PickedUpStatus)
    end
  end
end
