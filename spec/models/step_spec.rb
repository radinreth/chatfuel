RSpec.describe Step do
  describe 'validations' do
    xit { should validate_uniqueness_of(:act).scoped_to(:message_id) }
  end
end
