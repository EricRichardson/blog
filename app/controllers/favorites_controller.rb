class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.new
    @post = Post.find params[:post_id]
    @favorite.user = current_user
    @favorite.post = @post

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to post_path(@post) }
        format.js { render '/favorites/write_favorite' }
      else
        format.html { redirect_to post_path(@post) }
        format.js { redirect_to post_path(@post) }
      end
    end
  end

  def destroy
    @favorite = Favorite.find params[:id]
    @post = Post.find params[:post_id]
    @favorite.destroy

    respond_to do |format|
    format.html { redirect_to post_path(@post) }
    format.js { render '/favorites/write_favorite'}

    end
  end
end
