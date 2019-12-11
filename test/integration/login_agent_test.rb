require 'test_helper'

class LoginAgentTest < ActionDispatch::IntegrationTest

  def setup
    @agent = agents(:agent1)
  end

  test "誤った情報でのログイン" do
    get agent_login_path
    assert_template 'agent_sessions/new'
    post agent_login_path, params: { session: { email: "", password: "" } }
    assert_template 'agent_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "正しい情報でのログイン" do
    get agent_login_path
    post agent_login_path, params: { session: { email: @agent.email,
                                          password: '1234abcd' } }
    assert agent_is_logged_in?
    assert_redirected_to @agent
    follow_redirect!
    assert_template 'agents/show'
    assert_select "a[href=?]", agent_login_path, count: 0
    assert_select "a[href=?]", agent_logout_path
    assert_select "a[href=?]", agent_path(@agent)
    delete agent_logout_path
    assert_not agent_is_logged_in?
    assert_redirected_to root_url
    delete agent_logout_path
    follow_redirect!
    assert_select "a[href=?]", agent_login_path
    assert_select "a[href=?]", agent_logout_path, count: 0
    assert_select "a[href=?]", agent_path(@agent), count: 0
  end

  test "remember_meオン" do
    agent_login(@agent, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "remember_meオフ" do
    agent_login(@agent, remember_me: '1')
    delete agent_logout_path
    agent_login(@agent, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
