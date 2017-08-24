class UserNotifier < ApplicationMailer
	default :from => 'ccevans1@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for with Zoe' )
  end

  def send_account_setup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for registering your art account with Zoe' )
  end
end
