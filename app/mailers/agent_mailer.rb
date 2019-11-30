class AgentMailer < ApplicationMailer

  def account_activation(agent)
    @agent = agent
    mail to: agent.email, subject: "アカウント有効化"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
