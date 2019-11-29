class AgentSessionsController < ApplicationController
  def new #ログイン画面
  end

  def create #ログイン処理
    agent = Agent.find_by(email: params[:session][:email].downcase)
    if agent && agent.authenticate(params[:session][:password])
      agent_log_in agent
      params[:session][:remember_me] == '1' ? agent_remember(agent) : forget(agent)
      redirect_back_or agent
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
