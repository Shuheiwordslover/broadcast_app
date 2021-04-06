class BroadcastController < ApplicationController
  def new
    @broadcast = Broadcast.new
  end

  def create

    require 'nkf'
    require "csv"
    #毎回データベースを中身は空にしたいので、destroy_allを利用する。
    Broadcast.destroy_all
    text = CSV.parse(NKF.nkf( "-S -w -Lw", params[:broadcast][:file].read))
    num =1
    #ファイルの名前をグローバル変数でおいておく。
    $file_name = params[:broadcast][:file].original_filename
    p "これが表示されないと本当に始まらない"
    p text[0][0]

    range = Range.new(1,text.count)
    a = 1
    while !text[a-1].blank? do
      @broadcast = Broadcast.new(id:a)
      @broadcast.email = text[a-1][0]
      range. each do |k|
        column = "column"+"#{k}"
        @broadcast.update("#{column}":text[a-1][k])
      end
      @broadcast.save!(validate: false) if a==1
      @broadcast.save
      a += 1
    end
    redirect_to broadcast_mail_entry_path
  end

  def mail_entry
  end

  def confirm_email
    user = User.new
    $body= params[:statement][:body]
    $subject= params[:statement][:subject]

    #アメリカンカッコか日本語カッコか
    if (params[:statement][:bracket]==1)
      $subject ="【" + $user + "】"+ params[:statement][:subject]
    else
      $subject ="[" + $user + "]" + params[:statement][:subject]
    end



    title = Broadcast.find(1)
    @subject = $subject
    if @subject.include?("<"+title[:email]+">")
        @subject = @subject.gsub("<"+title[:email]+">",Broadcast.find(2)[:email])
    end
    range = Range.new(1,100000)
    range. each do |k|
      column = "column"+"#{k}"
      if title["#{column}"]
        @subject = @subject.gsub("<"+title["#{column}"]+">",Broadcast.find(2)["#{column}"])
      else
        break
      end
    end

    @body = $body
    if @body.include?("<"+title[:email]+">")
        @body = @body.gsub("<"+title[:email]+">",Broadcast.find(2)[:email])
    end
    range. each do |k|
      column = "column"+"#{k}"
      if title["#{column}"]
        @body = @body.gsub("<"+title["#{column}"]+">",Broadcast.find(2)["#{column}"])
      else
        break
      end
    end
  end



  def preview_all

    @broadcasts = Broadcast.new
    @body = $body
    @subject = $subject
    @sec = Broadcast.find(1).string.split(",")

  end

  def sent_message
    @body = $body
    @subject = $subject
    broadcasts = Broadcast.where.not(id:1)


    @sec = Broadcast.find(1).string.split(",")
    range1 = Range.new(0, @sec.count-1)


    broadcasts.each do |broadcast|
    subject = @subject
    body = @body
      range1.each do |i|

        if subject.include?("<"+@sec[i]+">")

          subject = subject.gsub("<"+@sec[i]+">",broadcast.string.split(",")[i])

        end

        if body.include?("<"+@sec[i]+">")
          body = body.gsub("<"+@sec[i]+">",broadcast.string.split(",")[i])
        end
      end
    ContactMailer.delay.broadcast_send_mail(broadcast.string.split(",")[0],subject,body)
    end
  end
end
