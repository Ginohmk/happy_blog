class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments
  has_many :likes
  belongs_to :user

  # A method that updates the posts counter for a user.
  def self.update_counter(user_id)
    counts = Post.where(user_id: user_id).count
    user = User.find(user_id)
    user.update(posts_counter: counts)
  end

  # A method which returns the 5 most recent comments for a given post.
  def five_recent_comment(post_id)
    Comment.where(post_id: post_id).order(created_at: :desc).first(5)
  end
end
