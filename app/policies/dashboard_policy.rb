class DashboardPolicy < Struct.new(:user, :dashboard)
  def show?
    user.system_admin? || user.site_admin?
  end

  def setting?
    user.system_admin?
  end
end
