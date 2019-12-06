require 'test_helper'

class AgentSessionsHelperTest < ActionView::TestCase

  def setup
    @agent = agents(:agent1)
    agent_remember(@agent)
  end

  test "current_agentは、sessionがnilでもrightを返す" do
    assert_equal @agent, current_agent
    assert agent_is_logged_in?
  end

  test "current_agentは、記憶ダイジェストが異なる値の時nilを返す" do
    @agent.update_attribute(:remember_digest, Agent.digest(Agent.new_token))
    assert_nil current_agent
  end
end
