class DashboardController < ApplicationController
  def show
    @user_count = Message.count
  end
end
