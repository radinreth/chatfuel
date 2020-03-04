class SitePolicy < ApplicationPolicy
  def index?
    user.system_admin?
  end

  def edit?
    user.system_admin?
  end

  def update?
    user.system_admin?
  end

  def destroy?
    user.system_admin?
  end
end
