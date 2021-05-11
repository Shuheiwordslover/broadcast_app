class ContactMailer < ApplicationMailer

  def broadcast_send_mail(target,subject,body)
    @body= body
    mail(to:target,subject:subject)
    @user = User.find(28)
    ActionMailer::Base.smtp_settings[:address] = @user.address
    ActionMailer::Base.smtp_settings[:port] = @user.port
    ActionMailer::Base.smtp_settings[:domain] = @user.domain
    ActionMailer::Base.smtp_settings[:user_name] = @user.user_name
    ActionMailer::Base.smtp_settings[:password] = @user.smtp_password
    ActionMailer::Base.smtp_settings[:authentication] = @user.authentication
    ActionMailer::Base.smtp_settings[:enable_starttls_auto] = @user.enable_starttls_auto
  end

end
