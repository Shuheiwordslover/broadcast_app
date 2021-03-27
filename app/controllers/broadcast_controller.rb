class BroadcastController < ApplicationController
  def new
    @broadcast = Broadcast.new
  end

  def create
    require 'nkf'
    @broadcast = Broadcast.new(broadcast_params)
    text = CSV.parse(NKF.nkf( "-S -w -Lw", broadcast_params[:file].read ))
    redirect_to root_url
  end

  def mail_entry
  end

  def confirm_email
  end

  def preview_all
  end

  def sent_message
  end
  private

    def broadcast_params
      params.require(:user).permit(:name,:file)
    end


end
