class BroadcastController < ApplicationController
  include BroadcastHelper
  def new
  end
  #csvファイルからデータベースにカラム名＋データを格納する関数
  def create
    #if文の左側はそもそもファイルが選択されてないので、params[:session]がnilになること利用
    #
    if (params[:session].nil?)||(!params[:session][:file].original_filename.include?(".csv"))
      flash[:danger] ="csvファイルを選択してください。"
      render "new"
    else

      require 'nkf'
      require "csv"
      #毎回データベースを中身は空にしたいので、destroy_allを利用する。
      Broadcast.destroy_all

      #セッションに入ってるファイル名とフォームで入れたファイルが違うなら
      if !(session[:file]==params[:session][:file].original_filename)
        #ファイルの名前をグローバル変数でおいておく。
        session[:file]=params[:session][:file].original_filename
        yomikomi = params[:session][:file].read
        text = CSV.parse(NKF.nkf( "-S -w -Lw", yomikomi))
        session[:text] =text
      end

      num =1

      #データベースにcsvの情報を格納する
      session[:count] = session[:text].count
      range = Range.new(1,session[:count]-1)
      a = 1
      while !session[:text][a-1].blank? do
        @broadcast = Broadcast.new(id:a)
        @broadcast.email = session[:text][a-1][0]
        if !@broadcast.email
          flash.now[:danger]="メールアドレスが空白、もしくは有効でない"
          session[:file]=nil
          render "new"
          return
        end
        range. each do |k|
          column = "column"+"#{k}"
          @broadcast.update("#{column}": session[:text][a-1][k])
          if (a==1 && @broadcast.attributes[column].nil?)
            p @broadcast.attributes[column]
            p "夕焼け空は赤い、炎のように赤い"
            flash.now[:danger]="カラム名は必ずいれてください"
            session[:file]=nil
            render "new"
            return
          end
          if (!(a==1) && @broadcast.attributes[column].nil?)
            p "ここ通ってたらnil””になってるはず"
            @broadcast.update("#{column}": "")
          end
        end
        @broadcast.save!(validate: false) if a==1
        @broadcast.save
        a += 1
      end
      redirect_to broadcast_mail_entry_path
    end


  end

  def delete_filename
    session[:file]=nil
    render "new"
  end

  def mail_entry
    @range = Range.new(1,session[:count]-1)
    @broadcast = Broadcast.find(1)
  end
  def render_mail_entry
    redirect_to broadcast_mail_entry_path
  end

  def render_select_file
    render "new"
  end
  def confirm_email

    if [(session[:body].blank? || session[:subject].blank?)] || [!(session[:body]==params[:session][:body]) || !(session[:subject]==params[:session][:subject])]
      #アメリカンカッコか日本語カッコか
      session[:body] = params[:session][:body]
      session[:subject] = params[:session][:subject]
    end
    @range = Range.new(2,session[:count]-1)

    user = User.new
    make_body_and_subject_for_each
    @broadcast = Broadcast.find(2)
  end



  def preview_all
    @broadcast = Broadcast.where.not(id:1)

  end

  def sent_message
    broadcasts = Broadcast.where.not(id:1)
    broadcasts.each do |broadcast|
      ContactMailer.delay.broadcast_send_mail(broadcast.email,broadcast.subject,broadcast.body)
    end
    b=Mailinfo.new("body": session[:body], "subject": session[:subject],"user_id": session[:user_id])
    b.save

  end



  private
    def make_body_and_subject_for_each
      title = Broadcast.find(1)
      targets_range = Range.new(1,Broadcast.all.count)
      i =2
      while i <= Broadcast.all.count
        @subject =session[:subject]
        @body = session[:body]
        target =Broadcast.find(i)
        if @subject.include?("<"+title[:email]+">")
            @subject = @subject.gsub("<"+title[:email]+">",target[:email])
        end
        if @body.include?("<"+title[:email]+">")
            @body = @body.gsub("<"+title[:email]+">",target[:email])
        end
        targets_range. each do |k|
          column = "column"+"#{k}"
          if title["#{column}"]
            @subject = @subject.gsub("<"+title["#{column}"]+">",target["#{column}"])
            @body = @body.gsub("<"+title["#{column}"]+">",target["#{column}"])
          end
        end
        target.update("body": @body)
        target.update("subject": @subject)
        i += 1
      end
    end




end
