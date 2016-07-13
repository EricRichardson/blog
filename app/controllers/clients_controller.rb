class ClientsController < ApplicationController

  def index
    render json: Post.all, each_serializer: PostIndexSerializer
  end

  def show
    post =  Post.find(params[:id])
    render json: post
  end

end
