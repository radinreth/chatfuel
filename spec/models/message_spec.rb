RSpec.describe Message do
  describe 'associations' do
    it { should have_many(:steps) }
    it { should belong_to(:content) }
  end

  describe 'delegates' do
    it { should delegate_method(:type).to(:content) }
    it { should delegate_method(:session_id).to(:content) }
  end
end
