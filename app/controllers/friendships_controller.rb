class FriendshipsController < ApplicationController

  def create
    @fs = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    if @fs.save
      flash[:notice] = "Friend request accepted."
      redirect_to user_notifications_path(current_user)
    else
      flash[:alert] = "Something went wrong with becoming friends, try again."
      redirect_to user_notifications_path(current_user)
    end
  end

  def destroy
    @fs = Friendship.find(params[:id])
    @fs.destroy
    flash[:notice] = "Friend request declined." 
    redirect_to user_notifications_path(current_user)
  end
end
