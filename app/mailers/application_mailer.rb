class ApplicationMailer < ActionMailer::Base
  if User.find_by(name:"current_user")
    default from: "#{User.find_by(name:"current_user").user_name}",
    layout: 'mailer'
  else
    default from: "from@example.com",
    layout: 'mailer'
end
end
