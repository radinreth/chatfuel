# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint(8)        not null, primary key
#  media_url  :string
#  status     :integer(4)       default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  step_id    :bigint(8)
#
# Indexes
#
#  index_feedbacks_on_step_id  (step_id)
#
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { is_expected.to have_attribute(:media_url) }
  it { is_expected.to define_enum_for(:status)
        .with_values(%i[satisfied disatisfied]) }
  it { is_expected.to belong_to(:step) }
end
