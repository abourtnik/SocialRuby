class PostsController < ApplicationController

  def create
    @post = Post.create(post_params)
    redirect_to root_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    post_params = params.require(:post).permit(:content)
    @post.update(post_params)
    redirect_to root_path
  end

  def delete
    @post = Post.find(params[:id])
  end

  def like

    @response = {'error' => true}
    @post = Post.find(params[:id])

    if (@post)
      #Verify if user not already like post
      if(true)
        Like.create(user: current_user, post: @post)
        @response['like_count'] = Like.where(post_id: @post.id).count
        @response['error'] = false
      else
        @response['message'] = 'Already like'
      end
    else
      @response['message'] = 'Post not found'
    end
    render json: @response
  end

  def unlike

    @response = {'error' => true}
    @post = Post.find(params[:id])

    if (@post)
      Like.where("user_id = ? AND post_id = ?", current_user.id, @post.id).delete_all
      @response['like_count'] = Like.where(post_id: @post.id).count
      @response['error'] = false
    else
      @response['message'] = 'Post not found'
    end
    render json: @response
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user: current_user)
  end

end
