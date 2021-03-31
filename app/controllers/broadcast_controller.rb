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
    @broadcast = Broadcast.new

    #カラムの名前になる行
    @sec = Broadcast.find(1).string.split(",")

    range1 = Range.new(0, Broadcast.count-1)
    range1.each do |i|
      if $body.include?("<"+sec[i]+">")
        $body = $body.gsub("<"+sec[i]+">",Broadcast.find(2).string.split(",")[i])
      end
      if $subject.include?("<"+sec[i]+">")
        $subject = $subject.gsub("<"+sec[i]+">",Broadcast.find(2).string.split(",")[i])
      end
    end
  end

  def preview_all
    @broadcast = Broadcast.new
    @sec = Broadcast.find(1).string.split(",")

    range1 = Range.new(0, Broadcast.count-1)
    range1.each do |i|
      if $body.include?("<"+sec[i]+">")
        $body = $body.gsub("<"+sec[i]+">",Broadcast.find(2).string.split(",")[i])
      end
      if $subject.include?("<"+sec[i]+">")
        $subject = $subject.gsub("<"+sec[i]+">",Broadcast.find(2).string.split(",")[i])
      end
    end
  end

  def sent_message
  end
  private



end
