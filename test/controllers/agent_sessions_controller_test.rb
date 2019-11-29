require 'test_helper'

class AgentSessionsControllerTest < ActionDispatch::IntegrationTest
  test "ログイン画面遷移テスト" do
    get agent_login_path
    assert_response :success
  end

  test "" do

  end
end
