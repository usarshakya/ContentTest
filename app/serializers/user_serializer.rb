class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :created_at, :updated_at
end
