class UserEmailMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]

    mail(to: 'taufikrahadi1@gmail.com', subject: 'Welcome to jungle')
  end
end
