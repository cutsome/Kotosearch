require 'test_helper'

class AgentMailerTest < ActionMailer::TestCase

  test "アカウント有効化" do
    agent = agents(:agent1)
    agent.activation_token = Agent.new_token
    mail = AgentMailer.account_activation(agent)
    #assert_equal "アカウント有効化", mail.subject
    assert_equal [agent.email], mail.to
    assert_equal ["norepry@Koto.jp"], mail.from
    assert_match agent.name, mail.body.encoded
    assert_match agent.activation_token, mail.body.encoded
    assert_match CGI.escape(agent.email), mail.body.encoded
  end
end
