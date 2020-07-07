class DashboardController < ApplicationController
  def show
    @platform_name = ["Messenger", "Telegram", "Verboice"]
    @goals = [accessed, submitted, completed]

    @location = params[:location] || "Banteay Meanchey"
    @start_date = params[:start_date] || 7.days.ago
    @end_date = params[:end_date] || Time.current

    @user_count = (helpers.join_text_message + helpers.join_voice_message).count
    @most_request_service = helpers.most_requested_service
  end

  private
    def accessed
      { name: "accessed", data: StepValue.joins(:variable_value).where(variable_values: { raw_value: "owso_info" }).group_by_day(:created_at).count }
    end

    def submitted
      { name: "submitted", data: Ticket.incomplete.group_by_day(:created_at).count }
    end

    def completed
      { name: "completed", data: Ticket.completed.group_by_day(:created_at).count }
    end
end
