class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post_for_destroy, only: [:destroy]
  before_action :set_post, only: [:show]
 
  def index
    if user_signed_in?
      friend_ids = current_user.friends.pluck(:id)
      @posts = Post.includes(:user, :likes, :comments, image_attachment: :blob)
                   .where(user_id: [current_user.id] + friend_ids)
                   .order(created_at: :desc)
    else
      @posts = Post.includes(:user, :likes, :comments, image_attachment: :blob)
                   .order(created_at: :desc)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_post_for_destroy
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :image)
  end
end