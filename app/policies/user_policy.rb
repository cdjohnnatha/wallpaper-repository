# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    user_present? && is_owner?
  end

  def create?
    false
  end

  def update?
    user_present? && is_owner?
  end

  def destroy?
    user_present? && is_owner?
  end

  private

  def user_present?
    true if user.present?
  end

  def is_owner?
    true if user == record
  end

  # def article
  #   record
  # end
end
