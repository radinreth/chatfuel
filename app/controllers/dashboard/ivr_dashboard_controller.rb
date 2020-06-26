module Dashboard
  class IvrDashboardController < DashboardController
    def show
      @user_count = VoiceMessage.count
    end
  end
end
