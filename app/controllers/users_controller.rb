class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:update,:edit,:destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(30)
  end

  def show
    @user = User.find(params[:id])
    @actionplans = @user.actionplans.order(id: :desc).page(params[:page])
    @likes = @user.likes.page(params[:page])
    @actionplan_waits = @user.actionplans.where(status: 'アクションプラン').order(id: :desc).page(params[:page])
    @actionplan_nows = @user.actionplans.where(status: 'アクション中').order(id: :desc).page(params[:page])
    @actionplan_comps = @user.actionplans.where(status: 'コンプリート').order(id: :desc).page(params[:page])
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
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を更新しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報を更新できませんでした'
      render :edit
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end
  
  # 正しいユーザーかどうか確認する
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end  
end
