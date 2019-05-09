class FriendRequestsController < ApplicationController
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
    @fr = FriendRequest.find(params[:id])
    @fr.destroy
    flash[:notice] = "Friend request declined."
    redirect_to root
  end
end
