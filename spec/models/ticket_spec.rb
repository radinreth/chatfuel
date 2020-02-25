# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint           not null, primary key
#  code                :string           not null
#  status              :integer          default("0")
#  submitted_at        :date
#  completed_at        :date
#  actual_completed_at :date
#  picked_up_at        :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
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
