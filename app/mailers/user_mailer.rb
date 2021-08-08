class UserMailer < ApplicationMailer
  default from: 'harris@nimblelabs.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Budget Ninja!')
  end


  def invitation_email(invitation)
    @invitation = invitation
    mail(to: @invitation.email, subject: "You're Invited to Join Budget Ninja!")
  end

end
