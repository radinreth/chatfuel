module Dashboard
  class ChatbotDashboardController < DashboardController
    def show
      @user_count = TextMessage.count
    end
  end
end
