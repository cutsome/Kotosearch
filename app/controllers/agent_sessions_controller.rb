class AgentSessionsController < ApplicationController
  def new #ログイン画面
  end

  def create #ログイン処理
    agent = Agent.find_by(email: params[:session][:email].downcase)
    if agent && agent.authenticate(params[:session][:password])
      if agent.activated?
        agent_log_in agent
        params[:session][:remember_me] == '1' ? agent_remember(agent) : forget(agent)
        redirect_to agent
      else
        message = "アカウントが有効化されていません"
        message += "メールのアカウント有効化リンクをお確かめください"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが間違っています"
      render 'agent_sessions/new'
    end
  end

  def destroy #ログアウト処理
    agent_log_out if agent_logged_in?
    redirect_to root_url
  end
end
