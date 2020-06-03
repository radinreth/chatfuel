RSpec.describe IncorrectStatus do
  let(:ticket) { build(:ticket) }
  let(:decorator) { TicketDecorator.new(ticket) }

  before do
    @picked_up = described_class.new(decorator)
  end

  it ":status" do
    expect(@picked_up).to respond_to(:status)
  end

  it ":description" do
    expect(@picked_up).to respond_to(:description)
  end
end
