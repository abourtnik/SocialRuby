class HomeController < ApplicationController

  def index

    if user_signed_in?

      @followings_ids = Follow.where(follower_id: current_user.id).pluck(:following_id)

      @posts = Post.where(user_id: @followings_ids).order('likes_count DESC')

      if (@posts.count < 10 && Post.count > @posts.count )
        @other_post = Post.where.not(user_id: current_user.id).order('likes_count DESC').limit(Post.count - @posts.count)
        @posts = @posts + @other_post
      end

      @post = Post.new

      #select all confirmed users except current user order by followers and templates
      @all_users = User.where.not(id: current_user.id).where.not(confirmed_at: nil).order('posts_count DESC')
      #select all followings by current user
      @followings = current_user.followings
      #Difference
      @users = (@all_users - @followings).take(10)

      render 'private'
    else
      @posts = Post.order(updated_at: :desc )
      render 'index'
    end

  end

  def private
  end

end
