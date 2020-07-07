module Dashboard
  class IvrDashboardController < DashboardController
    def show
      super
      @platform_name = ["Verboice"]
      @user_count = helpers.join_voice_message.count
    end
  end
end
