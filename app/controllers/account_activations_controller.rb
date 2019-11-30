class AccountActivationsController < ApplicationController

  def edit
    agent = Agent.find_by(email: params[:email])
    owner = Owner.find_by(email: params[:email])
    object = agent || owner
    if object && !object.activated? && object.authenticated?(:activation, params[:id])
      object.activate
      object == agent ? agent_log_in(agent) : owner_log_in(owner)   #ログイン処理
      flash[:success] = "アカウントが有効化されました！"
      redirect_to object
    else
      flash[:danger] = "リンクが誤っています"
      redirect_to root_url
    end
  end
end
