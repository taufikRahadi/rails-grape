class ApplicationMailer < ActionMailer::Base
  default from: "yourmail@mail.com"
  layout "mailer"
end
