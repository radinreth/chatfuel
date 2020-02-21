RSpec.describe Ticket, type: :model do
  describe 'attributes' do
    it { is_expected.to have_attribute(:code) }
    it { is_expected.to have_attribute(:status) }
    it { is_expected.to have_attribute(:submitted_at) }
    it { is_expected.to have_attribute(:completed_at) }
    it { is_expected.to have_attribute(:actual_completed_at) }
    it { is_expected.to have_attribute(:picked_up_at) }
  end

  describe 'validations' do
    it { is_expected.to define_enum_for(:status)
      .with_values(%i[submitted completed picked_up]) }
  end
end
