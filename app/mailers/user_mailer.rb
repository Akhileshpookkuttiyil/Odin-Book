class UserMailer < ApplicationMailer
  default from: 'welcome@odinbook.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Odin Book!')
  end
end