class UsersController < ApplicationController

  def show
    @user = User.find_by_id!(params[:id])
  end

  def follow

    @response = {'error' => true}
    @user = User.find(params[:id])

    if (params[:id] != current_user.id)
      if(@user)
        # Verify if select user don't have current user in your followers
        if(true)
          Follow.create(follower_id: current_user.id, following_id: @user.id)
          @response['error'] = false
        else
          @response['message'] = 'Already follow'
        end
      else
        @response['message'] = 'User not found'
      end
    else
      @response['message'] = 'One self'
    end
    render json: @response
  end

  def unfollow

    @response = {'error' => true}
    @user = User.find(params[:id])

    if (params[:id] != current_user.id)
      if(@user)
        Follow.where("follower_id = ? AND following_id = ?" , current_user.id , @user.id) .delete_all
        @response['error'] = false
      else
        @response['message'] = 'User not found'
      end
    else
      @response['message'] = 'One self'
    end
    render json: @response
  end

  def user_params
    params.require(:user).permit(:email, :password, :remember_me, :avatar, :avatar_cache, :remove_avatar)
  end

end
