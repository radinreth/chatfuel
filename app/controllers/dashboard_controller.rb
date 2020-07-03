class DashboardController < ApplicationController
  def show
    @message_type = "both"
    @location = params[:location] || "Banteay Meanchey"
    @start_date = params[:start_date] || 7.days.ago
    @end_date = params[:end_date] || Time.current

    @user_count = Message.merge(helpers.join_both_message).count
  end
end
