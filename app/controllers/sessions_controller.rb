class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.admin?
      log_in user
      redirect_to users_path
    else
      flash.now[:danger] = '管理者以外ははいれません'
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
