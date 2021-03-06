# == Schema Information
#
# Table name: reviews
#
#  id                  :bigint           not null, primary key
#  product_name        :string(255)      not null
#  content             :text(65535)      not null
#  picture             :string(255)
#  price               :integer
#  rating              :integer          not null
#  stamp_count         :integer          default(0)
#  user_id             :bigint
#  store_id            :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  product_category_id :bigint
#

class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :content, :comment_count, :first_picture_url, :created_at
  attribute :rating
  attribute :store_name
  attribute :product_category_name
  attribute :reactions

  belongs_to :user

  def reactions
    reactions = instance_options[:serialized_reaction_count_list]
    if reactions.present?
      instance_options[:reaction_counts].map do |r|
        { name: r[:name], count: r[:count], reacted: r[:reacted] } if r[:review_id] == object.id
      end.compact
    end
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :display_name, :login_name
    attribute :image_url

    def image_url
      object[:image_url]
    end
  end
end
