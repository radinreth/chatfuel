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
class Feedback < ApplicationRecord
  # associations
  belongs_to :step, optional: true
  belongs_to :site, optional: true
  has_one :rating
  has_one :variable, through: :rating

  scope :satisfied, -> { where(variable: Variable.satisfied.ids) }
  scope :disatisfied, -> { where(variable: Variable.disatisfied.ids) }
end
