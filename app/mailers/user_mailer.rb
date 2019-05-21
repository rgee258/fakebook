class UserMailer < ApplicationMailer

  def welcome_mail(user)
    mail to: user.email, subject: "Welcome to Fakebook!"
  end

end
