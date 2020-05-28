class TicketPolicy < ApplicationPolicy
  def index?
    user.system_admin?
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    index?
  end

  def new?
    create?
  end

  def update?
    index?
  end

  def edit?
    update?
  end

  def destroy?
    index?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
