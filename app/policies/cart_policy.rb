# frozen_string_literal: true
class CartPolicy < ApplicationPolicy
  def create?
    user_present?
  end

  def show?
    user_present? && owner?
  end

  def update?
    user_present? && owner?
  end

  def destroy?
    user_present? && owner?
  end

  private

  def user_present?
    user.present?
  end

  def owner?
    user == record.user
  end
end
