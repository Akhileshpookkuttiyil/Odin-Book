class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to @post, notice: "Post liked!"
    else
      redirect_to @post, alert: "Already liked this post."
    end
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    @like&.destroy
    redirect_to @post, notice: "Post unliked."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
