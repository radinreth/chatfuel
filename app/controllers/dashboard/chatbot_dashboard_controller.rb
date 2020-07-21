module Dashboard
  class ChatbotDashboardController < DashboardController
    def show
      super
      @options[:platform_name] = ["Messenger", "Telegram"]
      @options[:user_count] = [:text_message_count]
    end
  end
end
