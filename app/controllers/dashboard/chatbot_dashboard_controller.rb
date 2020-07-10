module Dashboard
  class ChatbotDashboardController < DashboardController
    def show
      super
      @options[:platform_name] = ["Messenger", "Telegram"]
      @options[:user_count] = [:join_text_message]
    end
  end
end
