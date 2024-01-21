class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)

    if @prototype.save
      redirect_to root_path, notice: 'プロトタイプを作成しました。'
    else
      # エラー時には、再度 new アクションを呼び出す前に入力済みの項目を保持
      @prototype.title = params[:prototype][:title]
      @prototype.catch_copy = params[:prototype][:catch_copy]
      @prototype.concept = params[:prototype][:concept]
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
  end

  def update
    # 更新が失敗した場合、入力済みの項目を保持する
    unless @prototype.update(prototype_params)
      @prototype.title = params[:prototype][:title]
      @prototype.catch_copy = params[:prototype][:catch_copy]
      @prototype.concept = params[:prototype][:concept]
    end

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'プロトタイプを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    # プロトタイプを削除
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def authorize_user!
    unless current_user == @prototype.user
      redirect_to root_path, alert: '他のユーザーのプロトタイプは編集できません。'
    end
  end
end