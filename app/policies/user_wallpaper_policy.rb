# frozen_string_literal: true

class UserWallpaperPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user_present?
  end

  def show?
    true
  end

  def update?
    user_present? && is_owner?
  end

  def destroy?
    user_present? && is_owner?
  end

  private

  def user_present?
    user.present?
  end

  def is_owner?
    user == record.user
  end
end
