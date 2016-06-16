class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
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
    @comments = Comment.order(created_at: :desc)
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

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def find_post
    @post = Post.find params[:id]
  end
end
