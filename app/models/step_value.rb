# == Schema Information
#
# Table name: step_values
#
#  id                :bigint(8)        not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  message_id        :bigint(8)        not null
#  site_id           :bigint(8)
#  variable_id       :bigint(8)        not null
#  variable_value_id :bigint(8)        not null
#
# Indexes
#
#  index_step_values_on_message_id         (message_id)
#  index_step_values_on_site_id            (site_id)
#  index_step_values_on_variable_id        (variable_id)
#  index_step_values_on_variable_value_id  (variable_value_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (site_id => sites.id)
#  fk_rails_...  (variable_id => variables.id)
#  fk_rails_...  (variable_value_id => variable_values.id)
#
class StepValue < ApplicationRecord
  has_paper_trail

  belongs_to :variable_value, counter_cache: true
  belongs_to :site, optional: true
  belongs_to :message
  belongs_to :variable

  validates :variable, uniqueness: { scope: :message }

  delegate :site_setting, to: :site, prefix: false, allow_nil: true

  after_create :push_notification, if: -> { variable_value.feedback_message? }
  after_create :set_message_district_id, if: -> { variable_value.is_location? }

  scope :most_recent, -> { select("DISTINCT ON (variable_id) variable_id, variable_value_id, id").order("variable_id, updated_at DESC") }

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
    scope = all
    scope = scope.joins(variable_value: :variable)
    scope = filter(scope, params)
    scope = scope.where(variables: { is_user_visit: true })
    scope = scope.order(:mapping_value)
    scope = scope.group(:mapping_value)
    scope.count
  end

  def self.number_of_tracking_tickets(params = {})
    scope = default_join.joins("INNER JOIN tickets on tickets.code=variable_values.raw_value")
    scope = filter(scope, params)
    scope = scope.group("tickets.status")
    scope.count
  end

  def self.total_users_feedback(params = {})
    scope = all
    statuses = VariableValue.statuses

    scope = filter(scope, params)
    report_variable = Variable.find_by(report_enabled: true)
    scope = scope.where(variable_id: report_variable)
    scope.joins(:variable_value).group(:status).count.map do |k, v|
      [statuses.key(k).capitalize, v]
    end.to_h
  end

  def self.most_request_service(params = {})
    scope = all
    scope = filter(scope, params)

    scope = scope.where('variable_id': Variable.where(is_most_request: true))
    scope = scope.order('count_all DESC')
    scope = scope.group('variable_value_id').limit(1)
    result = scope.count

    return {} if result.nil? || result.empty?

    variable_value = VariableValue.find(result.keys.first)
    {variable_value.mapping_value => result.values.first}
  end

  def self.default_join
    scope = all
    scope.joins(step: :message, variable_value: :variable)
  end

  def self.filter(scope, params={})
    scope = scope.where(message_id: Message.where(content_type: params[:content_type])) if params[:content_type].present?
    scope = scope.where(message_id: Message.where(province_id: params[:province_id])) if params[:province_id].present?
    scope = scope.where(message_id: Message.where(district_id: params[:district_id])) if params[:district_id].present?
    scope = scope.where(message_id: Message.where(platform_name: params[:platform_name])) if params[:platform_name].present?
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

    def set_message_district_id
      return if message.nil?

      message.update(district_id: variable_value.mapping_value[0..3])
    end
end
