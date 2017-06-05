class BinaryDownloadsByDateSerializer < ActiveModel::Serializer
  attributes :created_at_by_date
  
  def created_at_by_date
    object
  end
  
end