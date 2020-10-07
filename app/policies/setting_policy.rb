class SettingPolicy < Struct.new(:user, :dashboard)
  def index?
    user.system_admin?
  end

  def show?
    index?
  end

  def help?
    index?
  end

  def telegram_bot?
    index?
  end
end
