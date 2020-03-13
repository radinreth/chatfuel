class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.system_admin? || user.site_admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
