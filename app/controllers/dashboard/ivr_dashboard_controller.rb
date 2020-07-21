module Dashboard
  class IvrDashboardController < DashboardController
    def show
      super
      @options[:platform_name] = ["Verboice"]
      @options[:user_count] = [:voice_message_count]
    end
  end
end
