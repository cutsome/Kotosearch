require 'test_helper'

class AgentsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = agents(:agent1)
    @non_admin = agents(:agent2)
  end

  test "ページネーションテスト及び管理者権限による削除テスト" do
    agent_login(@admin)
    get agents_path
    assert_template 'agents/index'
    assert_select 'ul.pagination'
    assert_difference 'Agent.count', -1 do
      delete agent_path(@non_admin)
    end
  end

  test "非管理者のindex" do
    agent_login(@non_admin)
    get agents_path
    assert_select 'a', text: '削除', count: 0
  end
end
