class ActionplansController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      @actionplan = current_user.actionplans.build  # form_with 用
      @actionplans = current_user.actionplans.order(id: :desc).page(params[:page])
    end
  end

  def show
      @actionplan = current_user.actionplans.build  # form_with 用
      @actionplans = current_user.actionplans.order(id: :desc).page(params[:page])
  end

  def create
    @actionplan = current_user.actionplans.build(actionplan_params)
      
    if @actionplan.save
      flash[:success] = 'アクションプランを追加しました。'
      redirect_to root_url
    else
      @actionplans = current_user.actionplans.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'アクションプランの追加に失敗しました。'
      render 'top/index'
    end
  end

  def destroy
    @actionplan.destroy
    flash[:success] = 'アクションプランを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
    @actionplan = current_user.actionplans.find_by(id: params[:id])
  end

  def update
    if @actionplan.update(actionplan_params)
      flash[:success] = 'アクションプラン情報を更新しました'
      redirect_to @user
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
