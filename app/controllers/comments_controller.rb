class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :destroy, :edit, :update]
  before_action :find_comment, only: [:destroy, :edit, :update]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    if @comment.save
      redirect_to post_path @post
    else
      render :new
    end
  end

  def show

  end

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @comment.update comment_params
      redirect_to post_path @post
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path @post
  end

  private

    def find_post
      @post = Post.find_by_id params[:post_id]
    end

    def find_comment
        @comment = Comment.find params[:id]
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
