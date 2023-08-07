class Api::PostsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user!
  # respond_to :json
  # load_and_authorize_resource except: %i[index show]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(author_id: params[:user_id])
    if @posts
      render json: @posts.to_json, status: :ok
    else
      render json: { status: 'Error', errors: @posts.errors }
    end
  end
end
