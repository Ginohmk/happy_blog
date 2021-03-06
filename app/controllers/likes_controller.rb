class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(
      user_id: current_user.id,
      post_id: @post.id
    )
    if @like.save
      @like.like_count(params[:post_id])
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      redirect_to user_posts_path(params[:user_id])
    end
  end
end
