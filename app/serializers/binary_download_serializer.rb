class BinaryDownloadSerializer < ActiveModel::Serializer
  attributes :id, :binary_id, :user_id, :created_at
end
