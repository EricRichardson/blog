class HomeController < ApplicationController
  def index
    @posts = Post.most_recent
  end

  def about
  end
end
