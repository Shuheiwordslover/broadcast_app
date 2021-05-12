class ContactMailer < ApplicationMailer
  after_action :check_settings, only: :broadcast_send_mail
  def broadcast_send_mail(target,subject,body)
    @body= body
    mail(to:target,subject:subject)
    @user = User.find(26)
    if $mymail=="1"
      p "mymail側がきたー"
      ActionMailer::Base.smtp_settings[:address] = @user.address
      ActionMailer::Base.smtp_settings[:port] = @user.port
      ActionMailer::Base.smtp_settings[:domain] = @user.domain
      ActionMailer::Base.smtp_settings[:user_name] = @user.user_name
      ActionMailer::Base.smtp_settings[:password] = @user.smtp_password
      ActionMailer::Base.smtp_settings[:authentication] = @user.authentication
      ActionMailer::Base.smtp_settings[:enable_starttls_auto] = @user.enable_starttls_auto
      p ActionMailer::Base.smtp_settings
      p "しのぶさーーん死なないでー"
    end
  end
  def check_settings
    p ActionMailer::Base.smtp_settings
    p "ここ表示されろーーーーーしなずがわさんや"
  end
end
