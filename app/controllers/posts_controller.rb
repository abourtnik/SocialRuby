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
    @post = Post.find(params[:id])

    #Verify if user not already like post

      Like.create(user: current_user, post: @post)


    redirect_to root_path
  end

  def unlike
    @post = Post.find(params[:id])
    Like.where("user_id = ? AND post_id = ?", current_user.id, @post.id).delete_all
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:content).merge(user: current_user)
  end

end
