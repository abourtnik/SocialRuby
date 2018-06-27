class HomeController < ApplicationController

  def index

    if user_signed_in?
      @posts = Post.order(updated_at: :desc )
      @post = Post.new
      #@all_users = User.where.not(user_id: current_user.id)
      #@followings = current_user.followings
      @users = User.all()
      #@users = @all_users->diff($followings)->take(10);
      render 'private'
    else
      @posts = Post.order(updated_at: :desc )
      render 'index'
    end

  end

  def private
  end

end
