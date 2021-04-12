class ContactMailer < ApplicationMailer

  def broadcast_send_mail(target,subject,body)
    @body = body
    mail to:target,
       subject: subject

  end

end
