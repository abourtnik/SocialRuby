class PostsController < ApplicationController

  def create
    if @post = Post.create(post_params).valid?
      flash[:notice] = "Votre post a eté creé"
      redirect_to root_path
    else
      flash[:notice] = "Le format du post est incorrect"
      redirect_to root_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Votre post a été mis a jour"
      redirect_to edit_user_registration_path
    else
      flash[:notice] = "Le format du post est incorrect"
      redirect_to edit_post_path(@post.id)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Votre post a supprimé"
    redirect_to edit_user_registration_path
  end

  def like

    @response = {'error' => true}
    @post = Post.find(params[:id])

    if (@post)
      #Verify if user not already like post
      if(current_user.likes.where(post_id: @post.id).count < 1)
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
