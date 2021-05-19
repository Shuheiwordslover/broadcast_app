class ContactMailer < ApplicationMailer
  after_action :check_settings, only: :broadcast_send_mail
  def broadcast_send_mail(target,subject,body)
    @body= body
    mail(to:target,subject:subject)

    if $mymail =="1"
    @user = User.find(100000)
      ActionMailer::Base.smtp_settings[:address] = @user.address
      ActionMailer::Base.smtp_settings[:port] = @user.port
      ActionMailer::Base.smtp_settings[:domain] = @user.domain
      ActionMailer::Base.smtp_settings[:user_name] = @user.user_name
      ActionMailer::Base.smtp_settings[:password] = @user.smtp_password
      ActionMailer::Base.smtp_settings[:authentication] = @user.authentication
      ActionMailer::Base.smtp_settings[:enable_starttls_auto] = @user.enable_starttls_auto
    else
      ActionMailer::Base.smtp_settings[:address] = Settings.d_address
      ActionMailer::Base.smtp_settings[:port] = Settings.d_port
      ActionMailer::Base.smtp_settings[:domain] = Settings.d_domain
      ActionMailer::Base.smtp_settings[:user_name] = Settings.d_user_name
      ActionMailer::Base.smtp_settings[:password] = Settings.d_password
      ActionMailer::Base.smtp_settings[:authentication] = Settings.d_authentication
      ActionMailer::Base.smtp_settings[:enable_starttls_auto] = Settings.d_enable_starttls_auto
    end
  end

  def check_settings
    p ActionMailer::Base.smtp_settings
  end
end
