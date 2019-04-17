class PostsController < ApplicationController
  def index
    if params[:user]
      if User.exists? params[:user]
        @posts = Post.where(user_id: params[:user]).order(created_at: :desc)
        render json: @posts
      end
    end
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def new
    @post = Post.new
    render json: @post
  end

  def edit
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params.merge(user: current_user))
    @post.save
    render :new
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      head :ok
    else
      head :ok
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def like
    post = Post.find(params[:post_id])
    UpdateLikeCount.perform_async(post)
    Like.create(post: post, user: current_user)
    head :ok
  end

  def featured
    FindFeaturedPosts.perform_async
    @posts = Post.where(featured: true).order(created_at: :desc)
    render json: @posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
