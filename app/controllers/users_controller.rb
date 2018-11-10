class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    #@user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #binding.pry
    #@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報の更新に成功しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザ情報の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    #@user = User.find(params[:id])
    if @user.destroy
      flash[:success] = 'ユーザの削除に成功しました。'
      redirect_to root_url
    else
      flash[:danger] = 'ユーザの削除に失敗しました。'
      render :edit
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :introduce, :favoriteteam)
  end
end
