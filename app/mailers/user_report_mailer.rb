class UserReportMailer < ApplicationMailer
  def user_report
    @user = params[:user]
    @pdf = params[:pdf]

    attachments['file.pdf'] = @pdf
    mail(to: 'taufikrahadi1@gmail.com', subject: 'User Report')
  end
end
