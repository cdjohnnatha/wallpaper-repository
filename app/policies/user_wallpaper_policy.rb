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
