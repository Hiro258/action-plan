class ActionplansController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update,:edit,:destroy]
  
  def index
    if logged_in?
  #   @actionplans = Actionplan.order(id: :desc).page(params[:page]).per(30)
      @actionplan_waits = Actionplan.where(status: 'アクションプラン').order(id: :desc).page(params[:page]).per(30)
      @actionplan_nows = Actionplan.where(status: 'アクション中').order(id: :desc).page(params[:page]).per(30)
      @actionplan_comps = Actionplan.where(status: 'コンプリート').order(id: :desc).page(params[:page]).per(30)
    end
  end

  def show
    @actionplan = Actionplan.find_by(id: params[:id])
  end

  def create
    @actionplan = current_user.actionplans.build(actionplan_params)
      
    if @actionplan.save
      flash[:success] = 'アクションプランを追加しました。'
      
      redirect_to current_user;
      
#      @actionplans = Actionplan.order(id: :desc).page(params[:page]).per(30)
#      render :index
#      render 'users/show'
#　    redirect_back(fallback_location: root_path)
    else
      @actionplans = current_user.actionplans.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'アクションプランの追加に失敗しました。'
      render :new
    end
  end

  def destroy
    @actionplan.destroy
    flash[:success] = 'アクションプランを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def update
    if @actionplan.update(actionplan_params)
      flash[:success] = 'アクションプラン情報を更新しました'
      redirect_to current_user;
    else
      flash.now[:danger] = 'アクションプラン情報を更新できませんでした'
      render :edit
    end
  end

  def new
    @actionplan = current_user.actionplans.build  # form_with 用
  end
  
  private

  def actionplan_params
    params.require(:actionplan).permit(:action, :infosource, :study, :status)
  end
  
  def correct_user
    @actionplan = current_user.actionplans.find_by(id: params[:id])
    unless @actionplan
      redirect_to root_url
    end
  end

end
