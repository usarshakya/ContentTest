# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  country       :string
#  email         :string
#  first_name    :string
#  last_name     :string
#  password_hash :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  include RegexPattern

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX }
  validate :validate_password

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @new_password = new_password
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  private

  def validate_password
    errors.add(:password, "can't be blank") if @password.nil?

    return if PASSWORD_REGEX.match?(@new_password)

    errors.add(:password, 'must have at least one uppercase letter, one digit, one special character, and be at least 8 characters long')
  end
end
