require 'test_helper'

class AgentsEditTest < ActionDispatch::IntegrationTest

  def setup
    @agent = agents(:agent1)
  end

  test "誤った編集情報" do
    agent_login(@agent)
    get edit_agent_path(@agent)
    assert_template 'agents/edit'
    patch agent_path(@agent), params: { agent: { name: "",
                   email: "", password: "", password_confirmation: "" } }
    assert_template 'agents/edit'
  end

  test "正しい編集情報" do
    get edit_agent_path(@agent)
    agent_login(@agent)
    assert_redirected_to edit_agent_url(@agent)
    name = "masahiro nishikawa"
    email = "abcd@gmail.com"
    patch agent_path(@agent), params: { agent: { name: name, email: email } }
    assert_not flash.empty?
    assert_redirected_to @agent
    @agent.reload
    assert_equal name, @agent.name
    assert_equal email, @agent.email
  end
end
