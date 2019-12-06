require 'test_helper'

class AgentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @agent = agents(:agent1)
    @other_agent = agents(:agent2)
  end

  test "未ログイン状態でのeditアクセス" do
    get edit_agent_path(@agent)
    assert_not flash.empty?
    assert_redirected_to agent_login_url
  end

  test "未ログイン状態でのupdateアクセス" do
    patch agent_path(@agent), params: { agent: { name: @agent.name,
                                        email: @agent.email } }
    assert_not flash.empty?
    assert_redirected_to agent_login_url
  end

  test "ログイン済の他ユーザーからのeditアクセス" do
    agent_login(@other_agent)
    get edit_agent_path(@agent)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "ログイン済の他ユーザーからのupdateアクセス" do
    agent_login(@other_agent)
    patch agent_path(@agent), params: { agent: { name: @agent.name,
                                        email: @agent.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "Web経由で管理者権限が変更されないか" do
    agent_login(@other_agent)
    assert_not @other_agent.admin?
    patch agent_path(@agent), params: { agent: {
                             password: @other_agent.password,
                             password_confirmation: @other_agent.password,
                             admin: true } }
    assert_not @other_agent.reload.admin?
  end

  test "未ログイン状態での削除アクションはログイン画面にリダイレクト" do
    assert_no_difference 'Agent.count' do
      delete agent_path(@agent)
    end
    assert_redirected_to agent_login_url
  end

  test "ログイン済の他ユーザーからの削除アクションはルートにリダイレクト" do
    agent_login(@other_agent)
    assert_no_difference 'Agent.count' do
      delete agent_path(@agent)
    end
    assert_redirected_to root_url
  end
end
