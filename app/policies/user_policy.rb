class UserPolicy < ApplicationPolicy
  def new?
    !user.site_ombudsman?
  end

  def create?
    !user.site_ombudsman? && (User.roles[user.role] >= User.roles[record.role])
  end

  def roles
    return User.roles if user.system_admin?

    User.roles.keys.reject { |r| r == "system_admin" }.map { |r| [r, r] }
  end

  class Scope < Scope
    def resolve
      if user.system_admin?
        scope.all
      elsif user.site_admin?
        scope.where("role not in (?)", Role.where.not(name: 'system admin').ids)
      else
        scope.none
      end
    end
  end
end
