class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email (params[:email])
    if user
      token = reset_token
      user.update forgot_token: token
      url = edit_password_reset_url(user) + "/?token=#{token}"
      PasswordResetMailer.send_reset(user, url).deliver
      redirect_to root_path, notice: "The reset email has been sent!"
    else
      flash[:alert] = "Email not found"
      render :new
    end
  end

  def edit
    @token = params[:token]
  end

  def update
    user = User.find params[:id]
    if user.forgot_token == params[:token] && params[:new_password] == params[:new_password_confirmation]
      user.update password: params[:new_password]
      redirect_to root_path, notice: "Password reset!"
    else
      redirect_to root_path, notice: "Invalid reset token"
    end
  end

  private

  def reset_token
    SecureRandom.urlsafe_base64
  end
end
