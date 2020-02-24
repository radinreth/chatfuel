RSpec.describe CompletedStatus do
  let(:ticket) { build(:ticket) }
  let(:decorator) { TicketDecorator.new(ticket) }

  before do
    @completed = described_class.new(decorator)
  end

  it ":status" do
    expect(@completed).to respond_to(:status)
  end

  it ":description" do
    expect(@completed).to respond_to(:description)
  end
end
