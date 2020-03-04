class UserPolicy < ApplicationPolicy
  def roles
    return User.roles if user.system_admin?
    
    User.roles.keys.reject { |r| r == 'system_admin' }.map { |r| [r.titlecase, r] }
  end

  class Scope < Scope
    def resolve
      if user.system_admin?
        scope.all
      elsif user.site_admin?
        scope.where(role: %i[site_admin ombudsman])
      else
        scope.none
      end
    end
  end
end
