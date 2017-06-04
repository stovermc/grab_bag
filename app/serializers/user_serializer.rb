class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :phone, :created_at, :updated_at
end
