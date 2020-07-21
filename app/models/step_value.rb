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

  def self.total_users_visit_each_functions(params = {})
    scope = default_join
    scope = filter(scope, params)
    scope = scope.where(variables: { is_user_visit: true })
    scope = scope.order(:raw_value)
    scope = scope.group(:raw_value)
    scope.count
  end

  def self.number_of_tracking_tickets(params = {})
    scope = default_join.joins("INNER JOIN tickets on tickets.code=variable_values.raw_value")
    scope = filter(scope, params)
    scope = scope.group("tickets.status")
    scope.count
  end

  def self.total_users_feedback(params = {})
    scope = default_join
    scope = filter(scope, params)
    scope = scope.where(variables: { report_enabled: true })
    scope = scope.group(:raw_value)
    scope.count
  end

  def self.most_request_service(params = {})
    scope = default_join
    scope = filter(scope, params)
    scope = scope.where(variables: { is_most_request: true })
    scope = scope.order("count_all DESC")
    scope = scope.group("variable_values.raw_value").limit(1)
    scope.count
  end

  def self.accessed(params = {})
    scope = default_join
    scope = filter(scope, params)
    scope = scope.where("variable_values.raw_value = ?", "owso_info")
    scope = scope.group_by_day(:created_at)
    scope.count
  end

  def self.default_join
    scope = all
    scope.joins(step: :message, variable_value: :variable)
  end

  def self.filter(scope, params={})
    scope = scope.where(messages: { province_id: params[:province_id] }) if params[:province_id].present?
    scope = scope.where(messages: { platform_name: params[:platform_name] }) if params[:platform_name].present?
    scope = scope.where("DATE(step_values.created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope
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
