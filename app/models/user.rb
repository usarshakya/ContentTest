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

  validates :first_name, :last_name, :email, :password_hash, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: EMAIL_REGEX }

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    if PASSWORD_REGEX.match?(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    else
      errors.add(:password, 'Must be a valid password with at least one uppercase letter, one digit, one special character, and a length of 8 character')
      raise ActiveRecord::RecordInvalid, self
    end
  end
end
