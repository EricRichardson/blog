class PostsController < ApplicationController

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

  def show
    @post = post
  end

  def index
    #@posts = Post.order(created_at: :desc)
    @all_posts = Post.count
    current_page = params[:page]
    @posts = Post.paginate(current_page)
  end

  def edit
    @post = post
  end

  def destroy
    @post = post
    @post.destroy
    redirect_to posts_path
  end

  def update
    @post = post
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def search
    term = params[:search]
    @posts = Post.search(term)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def post
    Post.find params[:id]
  end
end
