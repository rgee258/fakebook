class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @like = Like.new(liking_user_id: current_user.id, liked_post_id: params[:id])
    if @like.save
      redirect_to post_path(params[:id])
    else
      flash[:alert] = "Trying to like this post failed, try again."
      redirect_to post_path(params[:id])
    end
  end

  def destroy
    Like.find_by(liking_user_id: current_user.id, liked_post_id: params[:id]).destroy
    redirect_to post_path(params[:id])
  end

end
