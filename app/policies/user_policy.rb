# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    user_present? && owner?
  end

  def create?
    false
  end

  def update?
    user_present? && owner?
  end

  def destroy?
    user_present? && owner?
  end

  private

  def user_present?
    true if user.present?
  end

  def owner?
    true if user == record
  end

  # def article
  #   record
  # end
end
