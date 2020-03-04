class UserPolicy < ApplicationPolicy
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
