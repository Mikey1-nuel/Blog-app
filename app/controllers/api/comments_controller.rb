class Api::CommentsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user!
  # respond_to :json

  def index
    @comments = Comment.where(post_id: params[:post_id])

    if @comments
      render json: { status: 'Success', data: @comments }
    else
      render json: { status: 'Error', data: @comments.errors }
    end
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = @user

    if @comment.save
      render json: @comment.to_json, status: :ok
    else
      render json: { status: 'Not Created', data: @comments.errors }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
