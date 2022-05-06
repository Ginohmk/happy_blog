class User < ApplicationRecord
  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  has_many :posts
  has_many :likes
  has_many :comments

  # A method that returns the 3 most recent posts for a given user.
  def three_recent_post(user_id)
    Post.order(updated_at: :desc).where(user_id: user_id).first(3)
  end
end
