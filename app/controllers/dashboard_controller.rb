class DashboardController < ApplicationController
  def show
    @platform_name = ["Messenger", "Telegram", "Verboice"]
    @goals = [accessed, submitted, completed].compact

    @location = params[:location] || "Banteay Meanchey"
    @start_date = params[:start_date] || 7.days.ago
    @end_date = params[:end_date] || Time.current

    @user_count = (helpers.join_text_message + helpers.join_voice_message).count
    @most_request_service = helpers.most_requested_service

    @user_visit_variable = Variable.find_by(is_user_visit: true)
    @most_request_variable = Variable.find_by(is_most_request: true)
    @report_enabled_variable = Variable.find_by(report_enabled: true)
  end

  private
    def accessed
      data = StepValue.joins(:variable_value).where(variable_values: { raw_value: "owso_info" }).group_by_day(:created_at).count
      { name: t("dashboard.accessed"), data: data } if data.present?
    end

    def submitted
      data = Ticket.incomplete.group_by_day(:created_at).count
      { name: t("dashboard.submitted"), data: data } if data.present?
    end

    def completed
      data = Ticket.completed.group_by_day(:created_at).count
      { name: t("dashboard.completed"), data: data } if data.present?
    end
end
