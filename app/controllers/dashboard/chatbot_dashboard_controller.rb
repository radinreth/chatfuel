module Dashboard
  class ChatbotDashboardController < DashboardController
    def show
      super
      @message_type = "text"
      @user_count = TextMessage.where("location_name=? and DATE(created_at) BETWEEN ? and ?", @location, @start_date, @end_date).count
    end
  end
end
