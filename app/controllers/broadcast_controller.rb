class BroadcastController < ApplicationController
  def new
    @broadcast = Broadcast.new
  end

  def create
    require 'nkf'
    require "csv"
    #毎回データベースを中身は空にしたいので、destroy_allを利用する。
    Broadcast.destroy_all
    num = 1
    text = CSV.parse(NKF.nkf( "-S -w -Lw", params[:broadcast][:file].read))
    #ファイルの名前をグローバル変数でおいておく。
    $file_name = params[:broadcast][:file].original_filename
    text. each do |text|
      @broadcast = Broadcast.new
      @broadcast.string = text
      @broadcast.id = num
      @broadcast.save
      @broadcast.string = @broadcast.string.sub(/\[/,"")
      @broadcast.string = @broadcast.string.sub(/\]/,"")
      @broadcast.string = @broadcast.string.gsub(/\"/,"")
      @broadcast.string = @broadcast.string.gsub(/\\/,"")
      @broadcast.string = @broadcast.string.gsub(/ /,"")
      @broadcast.save
      num += 1
    end
  end

  def mail_entry
    @box = Broadcast.find(1).string.split(",")
    @range = Range.new(0, @box.count-1)
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

end
