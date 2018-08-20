class HomeController < ApplicationController

  def index

    if user_signed_in?

      @followings_ids = Follow.where(follower_id: current_user.id).pluck(:following_id)
      @retweets_ids = Retweet.where(user_id: current_user.id).pluck(:post_id)

      @user_followings_posts = Post.where(user_id: @followings_ids).order('likes_count DESC').order('retweets_count DESC')
      @retweets_user_posts = Post.where(id: @retweets_ids).order('likes_count DESC').order('retweets_count DESC')
      @user_posts = Post.where(user_id: current_user.id).order('likes_count DESC').order('retweets_count DESC')

      @post = Post.new

      #select all confirmed users except current user order by followers and templates
      @all_users = User.where.not(id: current_user.id).where.not(confirmed_at: nil).order('posts_count DESC')
      #select all followings by current user
      @followings = current_user.followings
      #Difference
      @users = (@all_users - @followings).take(10)

      render 'private'
    else
      @posts = Post.order('likes_count DESC').order('retweets_count DESC')
      render 'index'
    end

  end

  def private
  end

end
