class BroadcastController < ApplicationController
  def new
    @broadcast = Broadcast.new
    ContactMailer.send_when_admin_reply.deliver_now
  end

  def create
    require 'nkf'
    require "csv"
    #毎回データベースを中身は空にしたいので、destroy_allを利用する。
    Broadcast.destroy_all
    num = 1
    text = CSV.parse(NKF.nkf( "-S -w -Lw", params[:broadcast][:file].read))
    text. each do |text|
      @broadcast = Broadcast.new
      @broadcast.string = text
      @broadcast.id = num
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
    @broadcast = Broadcast.find(1)
    p @broadcast.string.class

  end

  def preview_all
  end

  def sent_message
  end
  private



end
