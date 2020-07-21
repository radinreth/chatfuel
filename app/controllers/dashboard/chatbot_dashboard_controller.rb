module Dashboard
  class ChatbotDashboardController < DashboardController
    def show
      super
      @options[:platform_name] = ["Messenger", "Telegram"]
      @options[:user_count] = 'TextMessage'
    end
  end
end
