class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
  end

  def notifications
    @notifications = FriendRequest.where("recipient_id = ?", current_user.id).
      order(created_at: :desc)
  end

end
