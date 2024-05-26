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
class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :created_at, :updated_at

  attribute :token do
    instance_options[:token] if instance_options[:token].present?
  end
end
