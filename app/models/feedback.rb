# == Schema Information
#
# Table name: feedbacks
#
#  id              :bigint(8)        not null, primary key
#  additional_info :string
#  attitude        :string
#  difficulty      :string
#  efficiency      :string
#  overall         :string
#  process         :string
#  provide_info    :string
#  working_time    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  site_id         :bigint(8)
#  step_id         :bigint(8)
#
# Indexes
#
#  index_feedbacks_on_site_id  (site_id)
#  index_feedbacks_on_step_id  (step_id)
#
class Feedback < ApplicationRecord
  # associations
  belongs_to :step, optional: true
  belongs_to :site, optional: true
  has_one :rating
  has_one :variable, through: :rating

  has_one :rating, dependent: :destroy
  has_one :variable_value, through: :rating

  scope :satisfied, -> { joins(:variable_value).where("variable_values.id =? ", Variable.find_by(report_enabled: true).values.satisfied.ids) }
  scope :disatisfied, -> { joins(:variable_value).where("variable_values.id =? ", Variable.find_by(report_enabled: true).values.disatisfied.ids) }
end
