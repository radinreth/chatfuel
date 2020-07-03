module Dashboard
  class IvrDashboardController < DashboardController
    def show
      super
      @message_type = "voice"
      @user_count = VoiceMessage.where("DATE(created_at) BETWEEN ? AND ?", @start_date, @end_date).count
    end
  end
end
