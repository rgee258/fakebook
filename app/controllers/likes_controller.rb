class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @like = Like.new(liking_user_id: current_user.id, liked_post_id: params[:post_id])
    if @like.save
      redirect_to post_path(params[:post_id])
    else
      flash[:alert] = "Trying to like that post failed, try again."
      redirect_to posts_path
    end
  end

  def destroy
    Like.find(params[:like_id]).destroy
    redirect_to post_path(params[:post_id])
  end

end
