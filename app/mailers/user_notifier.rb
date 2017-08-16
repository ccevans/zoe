class UserNotifier < ApplicationMailer
	default :from => 'admin@capsulely.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for with Capsulely' )
  end

  def send_account_setup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for registering your brand with Capsulely' )
  end
end
