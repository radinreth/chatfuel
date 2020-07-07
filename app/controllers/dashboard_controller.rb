class DashboardController < ApplicationController
  def show
    @platform_name = ["Messenger", "Telegram", "Verboice"]

    @location = params[:location] || "Banteay Meanchey"
    @start_date = params[:start_date] || 7.days.ago
    @end_date = params[:end_date] || Time.current

    @user_count = (helpers.join_text_message + helpers.join_voice_message).count
  end
end
