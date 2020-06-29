# == Schema Information
#
# Table name: step_values
#
#  id                :bigint(8)        not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  site_id           :bigint(8)
#  step_id           :bigint(8)        not null
#  variable_value_id :bigint(8)        not null
#
# Indexes
#
#  index_step_values_on_site_id            (site_id)
#  index_step_values_on_step_id            (step_id)
#  index_step_values_on_variable_value_id  (variable_value_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#  fk_rails_...  (step_id => steps.id)
#  fk_rails_...  (variable_value_id => variable_values.id)
#
class StepValue < ApplicationRecord
  belongs_to :step
  belongs_to :variable_value
  belongs_to :site, optional: true

  delegate :site_setting, to: :site, prefix: false, allow_nil: true

  after_create :push_notification, if: -> { variable_value.feedback_message? }

  def self.satisfied
    return [] unless report_column

    satisfied = report_column.values.satisfied
    joins(:variable_value).where("variable_values.id in (?)", satisfied.ids)
  end

  def self.disatisfied
    return [] unless report_column

    disatisfied = report_column.values.disatisfied
    joins(:variable_value).where("variable_values.id in (?)", disatisfied.ids)
  end

  private
    def self.report_column
      @report_column ||= Variable.find_by(report_enabled: true)
    end

    def push_notification
      return unless (site_setting.present? && site_setting.message_frequency == 'immediately')

      AlertNotificationJob.perform_later(id)
    end
end
