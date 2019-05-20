class FriendshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    @fs = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    if @fs.save
      remove_friend_request
      flash[:notice] = "Friend request accepted."
      redirect_to user_notifications_path(current_user)
    else
      flash[:alert] = "Something went wrong with becoming friends, try again."
      redirect_to user_notifications_path(current_user)
    end
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:notice] = "Friend removed." 
    redirect_to users_path
  end

  private

  # Create a new instance of the friend request controller to call a specialized destroy
  def remove_friend_request
    fr_controller = FriendRequestsController.new
    fr_controller.destroy_after_accepted(params[:request_id])
  end
end
