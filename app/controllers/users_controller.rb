class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id).order(first_name: :asc)
    @friends = current_user.friends.ids
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id]).order(created_at: :desc)
  end

  def notifications
    @notifications = FriendRequest.where("recipient_id = ?", current_user.id).
      order(created_at: :desc)
  end

  # Used to redirect a logged in user to the user path with their id
  def home
    redirect_to user_path(current_user)
  end

end
