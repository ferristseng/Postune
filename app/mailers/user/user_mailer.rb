class User::UserMailer < ActionMailer::Base
  default from: Settings['email']['from']

  def reset_password(token)
  	@user = token.user
  	@url = "#{Settings['email']['base_url']}/reset?token=#{token.reset_token}"
  	mail(:to => @user.email, :subject => "Postune - Reset Password Notification")
  end

end
