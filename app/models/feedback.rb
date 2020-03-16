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
  # constants
  SATISFACTION_BOUNDARY = 4
  ANSWER_LIST = %w(មិនពេញចិត្តសោះ មិនពេញចិត្តខ្លាំង មិនពេញចិត្តតិចតួច អាចទទួលយកបាន ពេញចិត្តតិចខ្លះ ពេញចិត្តណាស់ ពេញចិត្តខ្លាំងណាស់)

  # associations
  belongs_to :step, optional: true
  belongs_to :site, optional: true

  # scopes
  scope :satisfied, -> { text_satisfied.or(voice_satisfied) }
  scope :disatisfied, -> { where.not(id: satisfied) }

  private
    def self.text_satisfied
      where(overall: ANSWER_LIST.last(SATISFACTION_BOUNDARY))
    end

    def self.voice_satisfied
      where("overall >= '?'", SATISFACTION_BOUNDARY)
    end
end
