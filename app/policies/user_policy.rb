class UserPolicy < Struct.new(:user, :record)
  def index?
    user.system_admin?
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def create?
    index?
  end

  def update?
    return false if record.id == user.id

    user.system_admin?
  end

  def destroy?
    update?
  end

  def roles
    Role.all.map { |role| role.name.parameterize(separator: "_") }
  end

  class Scope < ::ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
