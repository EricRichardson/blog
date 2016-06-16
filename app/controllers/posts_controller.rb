class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path @post
    else
      render :new
    end
  end

  def index
    @all_posts = Post.count
    current_page = params[:page] || 1
    @posts = Post.paginate(current_page)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def search
    term = params[:search]
    @posts = Post.search(term)
  end

  private

  def authenticate_user!
    redirect_to new_session_path, notice: "You need to be signed in" unless user_signed_in?
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def find_post
    @post = Post.find params[:id]
  end
end
