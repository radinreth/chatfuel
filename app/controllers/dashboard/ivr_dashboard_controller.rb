module Dashboard
  class IvrDashboardController < DashboardController
    def show
      super
      @message_type = "voice"
      @user_count = VoiceMessage.count
    end
  end
end
