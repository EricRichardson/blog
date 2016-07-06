class RatingsController < ApplicationController
  before_action :find_post
  def create
    @rating = Rating.new rating_params
    @rating.user = current_user
    @rating.post = @post
    if @rating.save
      redirect_to post_path(@post), notice: "Rating saved"
    else
      redirect_to post_path(@post), alert: "An Error Occured"
    end
  end

  def update
    @rating = Rating.find params[:id]
    @rating.update rating: params[:value]
  end

  private

    def find_post
      @post = Post.find(params[:post_id])
    end

    def rating_params
      params.require(:rating).permit(:rating)
    end
end
