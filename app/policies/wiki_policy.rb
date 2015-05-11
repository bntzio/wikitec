class WikiPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && (record.private? == false || (record.user == user) || (user.admin?))
  end

  def edit?
    update?
  end

  def update?
    user.present? && (record.private? == false || (record.user == user) || (user.admin?))
  end

  def destroy?
    user.present? && user.admin?
  end
end