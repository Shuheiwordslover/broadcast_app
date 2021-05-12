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
      flash.now[:danger] = '管理者以外は入れません'
      render "new"
    end
  end


  def create_user
    if params[:session][:email].empty?
      flash.now[:danger]="入力をしてください。"
      render "new_user"
      return
    end
    user = User.find_by(email: params[:session][:email].downcase)
    if user.nil?
      flash.now[:danger]="ユーザーは存在しないか削除されています。"
      render "new_user"
      return
    end
    session[:email] = params[:session][:email]
    session[:user_name] = user[:name]
    if user && user.authenticate(params[:session][:password])
      log_in user

      redirect_to broadcast_new_path
      flash.now[:success] = "正常にログインできました。"
    else
      flash.now[:danger] = "名前、もしくはパスワードが違います。"
      render "new_user"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
