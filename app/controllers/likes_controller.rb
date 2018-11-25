class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    m = Micropost.find(params[:micropost_id])
    current_user.like(m)
    flash[:success] = '投稿にいいねしました'
    redirect_to root_url
  end

  def destroy
    m = Micropost.find(params[:micropost_id])
    current_user.unlike(m)
    flash[:success] = 'いいねを解除しました'
    redirect_to root_url
  end
end
