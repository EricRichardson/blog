class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :find_user, only: [:edit, :update, :change_password, :update_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in()
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

  def change_password
  end

  def update_password
    if @user.authenticate(params[:password]) && params[:new_password] == params[:new_password_confirmation]
      @user.update password: params[:new_password]
      redirect_to root_path, notice: "Password changed"
    else
      flash[:alert] = "Error in input"
      render :change_password
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

    def password_params
      params.require(:user).permit(:new_password)
    end
end
