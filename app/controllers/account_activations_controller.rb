class AccountActivationsController < ApplicationController

  def edit
    agent = Agent.find_by(email: params[:email])
    owner = Owner.find_by(email: params[:email])
    object = agent || owner
    if object && !object.activated? && object.authenticated?(:activation, params[:id])
      object.activate
      agent_log_in(object) || owner_log_in(object)
      flash[:success] = "アカウントが有効化されました！"
      redirect_to object
    else
      flash[:danger] = "リンクが誤っています"
      redirect_to root_url
    end
  end
end
