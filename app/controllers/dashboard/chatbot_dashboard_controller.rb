module Dashboard
  class ChatbotDashboardController < DashboardController
    def show
      super
      @platform_name = ["Messenger", "Telegram"]
      @user_count = helpers.join_text_message.count
    end
  end
end
