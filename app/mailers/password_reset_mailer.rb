class PasswordResetMailer < ApplicationMailer
  default from: 'driftingeric@gmail.com'

  def send_reset (user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: "Password reset", template_name: "password_reset")
  end
end
