class SystemAdminPolicy < Struct.new(:user, :system_admin)
  def show?
    user.system_admin?
  end
end
