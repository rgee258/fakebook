class FriendRequestsController < ApplicationController

  before_action :authenticate_user!
  before_action :recipient_check, only: [:show]

  def show
    @fr = FriendRequest.find(params[:id])
    @sender = User.find(@fr.sender_id)
  end

  def create
    @fr = FriendRequest.new(sender_id: current_user.id, recipient_id: params[:recipient_id])

    if @fr.save
      flash[:notice] = "Friend request sent!"
      redirect_to users_path
    else
      flash[:alert] = "Problem sending friend request, try again later."
      redirect_to users_path
    end
  end

  def destroy
    FriendRequest.find(params[:id]).destroy
    flash[:notice] = "Friend request declined."
    redirect_to user_notifications_path(current_user)
  end

  # Seperate destroy method used only during friendship creation
  def destroy_after_accepted(request_id)
    FriendRequest.find(request_id).destroy
  end

  private

  def recipient_check
    unless FriendRequest.find(params[:id]).recipient_id == current_user.id
      flash[:alert] = "You do not have permission to view this friend request."
      redirect_to root_path
    end
  end
end
