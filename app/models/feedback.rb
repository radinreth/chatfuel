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
  # belongs_to :step, optional: true
  # belongs_to :site, optional: true

  # has_one :rating, dependent: :destroy
  # has_one :variable_value, through: :rating

  # scope :satisfied, -> { joins(:variable_value).where("variable_values.id in (?) ", Variable.find_by(report_enabled: true).values.satisfied.ids) }
  # scope :disatisfied, -> { joins(:variable_value).where("variable_values.id in (?) ", Variable.find_by(report_enabled: true).values.disatisfied.ids) }
end
