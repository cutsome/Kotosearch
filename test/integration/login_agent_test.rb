require 'test_helper'

class LoginAgentTest < ActionDispatch::IntegrationTest

  def setup
    @agent = agents(:agent1)
  end

  test "誤った情報でのログイン" do
    get login_agent_path
    assert_template 'agent_sessions/new'
    post login_agent_path, params: { session: { email: "", password: "" } }
    assert_template 'agent_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "正しい情報でのログイン" do
    get login_agent_path
    post login_agent_path, params: { session: { email: @agent.email,
                                          password: '1234abcd' } }
    assert agent_is_logged_in?
    assert_redirected_to @agent
    follow_redirect!
    assert_template 'agents/show'
    assert_select "a[href=?]", login_agent_path, count: 0
    assert_select "a[href=?]", logout_agent_path
    assert_select "a[href=?]", agent_path(@agent)
    delete logout_agent_path
    assert_not agent_is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_agent_path
    assert_select "a[href=?]", logout_agent_path, count: 0
    assert_select "a[href=?]", agent_path(@agent), count: 0
  end
end
