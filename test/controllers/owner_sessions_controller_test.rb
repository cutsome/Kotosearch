require 'test_helper'

class OwnerSessionsControllerTest < ActionDispatch::IntegrationTest
  test "ログイン画面遷移テスト" do
    get login_owner_path
    assert_response :success
  end

  test "" do

  end
end
