# frozen_string_literal: true
class CartItemPolicy < ApplicationPolicy
  def index?
    user_present? && owner?
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
    user == record.cart.user
  end
end
