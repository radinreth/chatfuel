require 'csv'

module StepValue::FilterableConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params={})
      scope = scope.all
      scope = scope.where(session_id: Session.where(gender: params[:gender])) if params[:gender].present?
      scope = scope.where(session_id: Session.where(session_type: params[:content_type])) if params[:content_type].present?
      scope = scope.where(session_id: Session.where(province_id: params[:province_id])) if params[:province_id].present?
      scope = scope.where(session_id: Session.where(district_id: params[:district_id])) if params[:district_id].present?
      scope = scope.where(session_id: Session.where(platform_name: params[:platform])) if params[:platform].present?
      scope = scope.where(variable: params[:varaible]) if params[:varaible].present?
      scope = scope.where("DATE(step_values.created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?

      scope
    end
  end
end
