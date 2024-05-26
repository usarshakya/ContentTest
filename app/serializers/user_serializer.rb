class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :created_at, :updated_at

  attribute :token do
    instance_options[:token] if instance_options[:token].present?
  end
end
