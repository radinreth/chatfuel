class UserPolicy < Struct.new(:user, :record)
  def index?
    !user.site_ombudsman?
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def create?
    (user.system_admin? || user.site_admin?) && \
    user.role_position_level > record.role_position_level
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

  class Scope < ::ApplicationPolicy::Scope
    def resolve
      if user.system_admin?
        scope.all
      elsif user.site_admin?
        scope.joins(:role).where("roles.name in (?)", ["site_admin", "site_ombudsman"])
      else
        scope.none
      end
    end
  end
end
