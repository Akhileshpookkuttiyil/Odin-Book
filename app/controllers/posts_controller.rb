class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :destroy]
 
  def index
    @posts = Post.all.order(created_at: :desc)
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

    def post_params
    params.require(:post).permit(:body)
  end

end
