class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :thread, foreign_key: 'in_reply_to_id', class_name: 'Comment', optional: true
  belongs_to :in_reply_to_user, foreign_key: 'in_reply_to_user_id', class_name: 'User', optional: true
  has_many :replies, foreign_key: 'in_reply_to_id', class_name: 'Comment', dependent: :destroy
  has_many :likes, dependent: :destroy

  before_save :set_reply_to_user_id
  after_create :count_up
  before_destroy :count_down

  validates :comment, presence: true, length: { maximum: 100 }

  scope :without_replies, -> {}

  def reply?
    !in_reply_to_id.nil? || attributes['reply']
  end

  def liked?(user)
    comment.likes.exists?(user_id: user.id)
  end

  private

  def set_reply_to_user_id
    if reply?
      comment = Comment.find_by(id: in_reply_to_id)
      self[:in_reply_to_user_id] = comment.user.id
    end
  end

  def count_up
    review.increment_comment_count
  end

  def count_down
    review.decrement_comment_count
  end
end
