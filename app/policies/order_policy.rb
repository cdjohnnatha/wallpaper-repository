# frozen_string_literal: true
class OrderPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def show?
    user_present? && owner?
  end

  def update?
    user_present? && owner?
  end

  def destroy?
    admin?
  end

  private

  def user_present?
    user.present?
  end

  def owner?
    user == record.user
  end

  def admin?
    user.admin?
  end
end
