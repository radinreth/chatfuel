module Dashboard
  class IvrDashboardController < DashboardController
    def show
      super
      @options[:platform_name] = ["Verboice"]
      @options[:user_count] = [:join_voice_message]
    end
  end
end
