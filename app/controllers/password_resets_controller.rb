class PasswordResetsController < ApplicationController
  before_action :get_object, only: [:edit, :update]
  before_action :valid_object, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @agent = Agent.find_by(email: params[:password_reset][:email].downcase)
    @owner = Owner.find_by(email: params[:password_reset][:email].downcase)
    @object = @agent || @owner
    if @object
      @object.create_reset_digest
      @object.send_password_reset_email
      flash[:info] = "パスワード再設定用メールをお送りしました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりません"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:object][:password].empty?
      @object.errors.add(:password, :blank)
      render 'edit'
    elsif @object.update(object_params)
      agent_log_in(@object) || owner_log_in(@object)
      @object.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードを再設定しました"
      redirect_to @object
    else
      render 'edit'
    end
  end

  private

    def object_params
      params.require(:object).permit(:password, :password_confirmation)
    end

    def get_object
      @agent = Agent.find_by(email: params[:email])
      @owner = Owner.find_by(email: params[:email])
      @object = @agent || @owner
    end

    def valid_object
      unless (@object && @object.activated? &&
             @object.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @object.password_reset_expired?
        flash[:danger] = "パスワード再設定の有効期限が切れています"
        redirect_to new_password_reset_path
      end
    end
end
