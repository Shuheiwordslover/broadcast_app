class ContactMailer < ApplicationMailer

  def send_when_admin_reply#メソッドに対して引数を設定
    @user = User.find_by(email: "shuhei@senkyo.co.jp")#ユーザー情報
    mail to:@user.email, subject:'【サイト名】 お問い合わせありがとうございます'
  end

end
