class DashboardController < ApplicationController
  def show
    @options = {
      location: (params[:location] || "Banteay Meanchey"),
      platform_name: ["Messenger", "Telegram", "Verboice"],
      start_date: (params[:start_date] || 7.days.ago),
      end_date: (params[:end_date] || Time.current),
      user_count: [:join_text_message, :join_voice_message]
    }
    @query = DashboardQuery.new(@options)
  end
end
