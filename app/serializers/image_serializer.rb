class ImageSerializer < ActiveModel::Serializer
  attributes :id, :image_url

  def image_url
    object.image_url
  end

end
