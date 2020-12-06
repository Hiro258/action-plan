class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    actionplan = Actionplan.find(params[:actionplan_id])
    current_user.addfavorite(actionplan)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_to current_user
    
  end

  def destroy
    actionplan = Actionplan.find(params[:actionplan_id])
    current_user.unfavorite(actionplan)
    flash[:success] = 'お気に入りから削除しました。'
     redirect_to current_user
  end
end
