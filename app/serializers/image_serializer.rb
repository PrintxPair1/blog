class ImageSerializer < ActiveModel::Serializer
  attributes :id, :data, :mime_type, :name
end
