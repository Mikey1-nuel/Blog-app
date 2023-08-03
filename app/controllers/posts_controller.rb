class PostsController < ApplicationController
  load_and_authorize_resource except: %i[index show]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(author_id: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:errors] = 'Invalid post!'
      render :new
    end
  end

  def destroy
    @post = @comment.post
    @user = @post.author
    @post.destroy
    redirect_to user_posts_path(@user), notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
