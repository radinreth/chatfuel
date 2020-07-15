class SitePolicy < ApplicationPolicy
  def index?
    user.system_admin?
  end

  def new?
    create?
  end

  def create?
    user.system_admin?
  end

  def edit?
    update?
  end

  def update?
    create?
  end

  def destroy?
    user.system_admin?
  end
end
