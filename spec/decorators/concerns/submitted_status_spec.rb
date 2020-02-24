RSpec.describe SubmittedStatus do
  let(:ticket) { build(:ticket) }
  let(:decorator) { TicketDecorator.new(ticket) }

  before do
    @submitted = described_class.new(decorator)
  end

  it ":status" do
    expect(@submitted).to respond_to(:status)
  end

  it ":description" do
    expect(@submitted).to respond_to(:description)
  end
end
