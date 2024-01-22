class UsersController < ApplicationController
  #before_action :authenticate_user!, only: [:show]  # ログインしていない場合はログインページにリダイレクト

  def show
    @user = User.find(params[:id])
    #@user = User.find(current_user.id)
  end
  
end
