Net::OpenTimeout=nil
class UsersController < ApplicationController
  before_action :logged_in_user#, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def new_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.login_id= User.maximum(:login_id)+1
      @user.save
      redirect_to users_path
      # Handle a successful save.
    else
      render 'new'
    end

  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find(params[:id])
    @mailinfos = @user.mailinfos.paginate(page: params[:page], per_page: 10)
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "編集しました"
      redirect_to users_path
    else
      render 'edit'
      flash[:danger] = "失敗しました"
    end
  end

  def send_mail
    p params
    p "何でもいいから声をきかせてよ"

    @user = User.find(params[:id])
    ActionMailer::Base.smtp_settings[:address] = @user.address
    ActionMailer::Base.smtp_settings[:port] = @user.port
    ActionMailer::Base.smtp_settings[:domain] = @user.domain
    ActionMailer::Base.smtp_settings[:user_name] = @user.user_name
    ActionMailer::Base.smtp_settings[:password] = @user.smtp_password
    ActionMailer::Base.smtp_settings[:authentication] = @user.authentication
    ActionMailer::Base.smtp_settings[:enable_starttls_auto] = @user.enable_starttls_auto
    ContactMailer.broadcast_send_mail(@user.email,"テストメール","テストメールです").deliver_later(1.minute)
    render 'edit'
    flash[:success] = "送りました"
    p ActionMailer::Base.smtp_settings
  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:login_id,
                                   :password_confirmation,:address, :port, :domain,
                                 :user_name, :smtp_password, :authentication,
                               :enable_starttls_auto)
    end

    def logged_in_user
      unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user|| !User.find(params[:id]).admin?
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin? || !User.find(params[:id]).admin?
  end
end
