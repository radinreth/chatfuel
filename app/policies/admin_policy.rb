class AdminPolicy < Struct.new(:user, :admin)
  def show?
    user.system_admin? || user.site_admin?
  end
end
