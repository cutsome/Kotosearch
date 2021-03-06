class OwnerSessionsController < ApplicationController
  def new #ログイン画面
  end

  def create #ログイン処理
    owner = Owner.find_by(email: params[:session][:email].downcase)
    if owner && owner.authenticate(params[:session][:password])
      if owner.activated?
        owner_log_in owner
        params[:session][:remember_me] == '1' ? owner_remember(owner) : forget(owner)
        redirect_to owner
      else
        message = "アカウントが有効化されていません。 "
        message += "メールのアカウント有効化リンクをお確かめください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが間違っています。"
      render 'owner_sessions/new'
    end
  end

  def destroy #ログアウト処理
    owner_log_out if owner_logged_in?
    redirect_to root_url
  end
end
