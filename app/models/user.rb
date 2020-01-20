# frozen_string_literal: true
class User < ApplicationRecord
  rolify
  acts_as_paranoid
  has_many :carts
  has_many :orders
  has_many :wallpapers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def admin?
    has_role?(:admin)
  end

  def client?
    has_role?(:client)
  end
end
