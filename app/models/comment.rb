class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # A method that updates the comments counter for a post.
  def self.comment_count(post_id)
    counts = Comment.where(post_id: post_id).count
    post = Post.find(post_id)
    post.update(comments_counter: counts)
  end
end
