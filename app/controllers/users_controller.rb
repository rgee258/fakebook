class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
    @posts = Post.where(user_id: current_user.id).order(created_at: :desc)
  end

  def notifications
    @notifications = FriendRequest.where("recipient_id = ?", current_user.id).
      order(created_at: :desc)
  end

end
