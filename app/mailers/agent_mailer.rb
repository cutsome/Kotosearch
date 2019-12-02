class AgentMailer < ApplicationMailer

  def account_activation(agent)
    @agent = agent
    mail to: agent.email, subject: "アカウント有効化"
  end

  def password_reset(agent)
    @agent = agent
    mail to: agent.email, subject: "パスワード再設定"
  end
end
