class BroadcastController < ApplicationController
  def new
    @broadcast = Broadcast.new
    #ContactMailer.send_when_admin_reply.deliver_now
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
    render "mail_entry"
  end

  def mail_entry
    render "confirm_email"

  end

  def confirm_email
    $body= params[:statement][:body]
    $subject = params[:statement][:subject]
    #Viewで使うためにインスタンス生成
    @broadcast = Broadcast.new
    @body = $body
    @subject = $subject
    #カラムの名前になる行
    @sec = Broadcast.find(1).string.split(",")
    range1 = Range.new(0, @sec.count-1)
    p @sec.count
    range1.each do |i|
      #subjectを書き換える
      if @subject.include?("<"+@sec[i]+">")
        @subject = @subject.gsub("<"+@sec[i]+">",Broadcast.find(2).string.split(",")[i])
      end

      if @body.include?("<"+@sec[i]+">")
        @body = @body.gsub("<"+@sec[i]+">",Broadcast.find(2).string.split(",")[i])
        p @body
        p Broadcast.find(2).string.split(",")[i]
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
    broadcasts = Broadcast.all


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
    if !(broadcast.id == 1)
      p "これが表示されてたらメールは送られてる"
      ContactMailer.broadcast_send_mail(broadcast.string.split(",")[0],subject,body).deliver_now
    end



    end
  end



  private
  def show_all_mail_lists
    @body = $body
    @subject = $subject
    @broadcasts = Broadcast.all
    range1 = Range.new(0, @sec.count-1)
    @broadcasts.each do |broadcast|
      range1.each do |i|
        if @subject.include?("<"+@sec[i]+">")
          @subject = @subject.gsub("<"+@sec[i]+">",boradcast.string.split(",")[i])
        end

        if @body.include?("<"+@sec[i]+">")
          @body = @body.gsub("<"+@sec[i]+">",boradcast.string.split(",")[i])
        end
      end
    end
  end




end
