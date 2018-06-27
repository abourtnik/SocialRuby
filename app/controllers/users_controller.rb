class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    Follow.create(follower_id: current_user.id, following_id: @user.id)
    redirect_to root_path
  end

  def unfollow
    @user = User.find(params[:id])
    Follow.where("follower_id = ? AND following_id = ?" , current_user.id , @user.id) .delete_all
    redirect_to root_path
  end

end
