class SessionsController < ApplicationController

  MAX_ATTEMPTS = 5
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    authed = user.authenticate(params[:password]) if user
    fails = user.failed_attempts
    flash[:alert] = "Account has been locked. Reset your password via email" if fails > MAX_ATTEMPTS
    if user && authed && fails <= MAX_ATTEMPTS
      sign_in(user)
      user.update failed_attempts: 0
      redirect_to root_path, notice: "Sign in Successful"
    else
      unless authed
        user.failed_attempts += 1
        user.save
      end
      flash[:alert] ||= "Incorrect Credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out"
  end
end
