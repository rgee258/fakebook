class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id])
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      flash.now[:alert] = "Error creating comment, try again."
      render 'new'
    end
  end

  def destroy
    Comment.find(params[:comment_id])
    redirect_to post_path(params[:id])
  end

end
