class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(body: params[:body], user_id: current_user.id)
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
end
