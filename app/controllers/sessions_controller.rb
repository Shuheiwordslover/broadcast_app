class SessionsController < ApplicationController
  def new
  end

  def new_user
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


  def create_user
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to broadcast_new_path
    else
      flash.now[:danger] = "名前、もしくはパスワードが違います。"
      render "new_user"
    end
    $user_email = params[:session][:email]
    $user = user.name
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
