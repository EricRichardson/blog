class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :find_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: "Account Made!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to root_path, notice: "Update successful"
    else
      flash[:alert] = "Error in your info"
      render :edit
    end
  end

  private
    def find_user
      @user = User.find session[:user_id]
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
