module Dashboard
  class ChatbotDashboardController < DashboardController
    def show
      super
      @message_type = "text"
      @user_count = TextMessage.count
    end
  end
end
