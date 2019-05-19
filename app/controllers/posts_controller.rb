class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    # This query gets the friend id's of the current user and adds the current user's id
    @posts = Post.where(user_id: current_user.friends.ids.unshift(current_user.id)).
      order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      flash.now[:alert] = "Error creating post, try again."
      render 'new'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "Post successfully destroyed."
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body)
  end
end
