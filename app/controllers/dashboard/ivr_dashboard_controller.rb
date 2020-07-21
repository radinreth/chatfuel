module Dashboard
  class IvrDashboardController < DashboardController
    def show
      super
      @options[:platform_name] = ["Verboice"]
      @options[:user_count] = 'VoiceMessage'
    end
  end
end
