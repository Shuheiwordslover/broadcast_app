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

  def create
    @user = User.new(user_params)
    if @user.save
      @user.login_id= User.maximum(:login_id)+1
      @user.save
      render "new"
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
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "編集しました"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:login_id,
                                   :password_confirmation)
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
    redirect_to(root_url) unless @user == current_user
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin? || !User.find(params[:id]).admin?
  end
end