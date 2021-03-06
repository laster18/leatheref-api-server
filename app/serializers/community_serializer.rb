class CommunitySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :symbol_image_path
  attributes :members_count

  belongs_to :owner, serializer: UserSerializer

  def members_count
    object.members.length
  end

  def symbol_image_path
    object.symbol_image&.url
  end
end
