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
    num =0
    #ファイルの名前をグローバル変数でおいておく。
    $file_name = params[:broadcast][:file].original_filename
    p "これが表示されないと本当に始まらない"
    p text.count
    range = Range.new(1,text.count-2)
      @broadcast = Broadcast.create(id:num)
      @broadcast.email = text[0]
      range. each do |k|
        column = "column"+"#{k}"
        @broadcast.update("#{column}",text[k])
      end
      @broadcast.save
      num += 1
    end
    redirect_to broadcast_mail_entry_path
  end

  def mail_entry
  end

  def confirm_email
    user = User.new
    $body= params[:statement][:body]
    if (params[:statement][:bracket]==1)
      $subject ="【" + $user + "】"+ params[:statement][:subject]
    else
      $subject ="[" + $user + "]" + params[:statement][:subject]
    end

    #Viewで使うためにインスタンス生成
    @broadcast = Broadcast.new
    @body = $body
    @subject = $subject
    #カラムの名前になる行
    @sec = Broadcast.find(1).string.split(",")
    range1 = Range.new(0, @sec.count-1)
    range1.each do |i|
      #subjectを書き換える
      if @subject.include?("<"+@sec[i]+">")
        @subject = @subject.gsub("<"+@sec[i]+">",Broadcast.find(2).string.split(",")[i])
      end

      if @body.include?("<"+@sec[i]+">")
        @body = @body.gsub("<"+@sec[i]+">",Broadcast.find(2).string.split(",")[i])
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



  private
