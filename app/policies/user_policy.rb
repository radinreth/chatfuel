class UserPolicy < ApplicationPolicy
  def new?
    !user.site_ombudsman?
  end

  def edit?
    !user.site_ombudsman?
  end

  def update?
    !user.site_ombudsman?
  end

  def create?
    !user.site_ombudsman? && (user.role.grade >= record.role&.grade.to_i)
  end

  # TODO: cleanup
  def roles
    Role.all.map do |r|
      key = r.name.parameterize(separator: "_")
      key
    end
    # return User.roles if user.system_admin?

    # User.roles.keys.reject { |r| r == "system_admin" }.map { |r| [r, r] }
  end

  class Scope < Scope
    def resolve
      if user.system_admin?
        scope.all
      elsif user.site_admin?
        scope.joins(:role).where("roles.name in (?)", ["site admin", "site ombudsman"])
      else
        scope.none
      end
    end
  end
end
