class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:comment][:post_id])
    else
      flash.now[:alert] = "Error creating comment, try again."
      render 'new'
    end
  end

  def destroy
    Comment.find(params[:comment_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end

end
