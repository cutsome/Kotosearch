class OwnersController < ApplicationController
  before_action :logged_in_owner, only: [:edit, :update, :destroy]
  before_action :correct_owner, only: [:edit, :update]
  before_action :admin_owner, only: :destroy

  def index
    @owners = Owner.all.page(params[:page]).per(20)
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      @owner.send_activation_email
      flash[:info] = "メールを確認し、アカウントを有効化してください"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def edit
    @owner.photo
  end

  def update
    if @owner.update(owner_params)
      flash[:success] = "編集が完了しました"
      redirect_to @owner
    else
      render 'edit'
    end
  end

  def destroy
    Owner.find(params[:id]).destroy
    flash[:success] = "ユーザーは削除されました"
    redirect_to owners_url
  end

  private
    def owner_params
      params.require(:owner).permit(
        :name, :email,
        :address, :scale,
        :period, :target_audience,
        :password, :password_confirmation, :photo,
        { leisure_ids: [] }
      )
    end

    def logged_in_owner
      unless owner_logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to owner_login_url
      end
    end

    def correct_owner
      @owner = Owner.find(params[:id])
      redirect_to root_url unless current_owner?(@owner)
    end

    def admin_owner
      redirect_to root_url unless current_owner.admin?
    end
end
