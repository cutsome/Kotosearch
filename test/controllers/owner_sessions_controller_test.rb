require 'test_helper'

class OwnerSessionsControllerTest < ActionDispatch::IntegrationTest
  test "ログイン画面遷移テスト" do
    get owner_login_path
    assert_response :success
  end

  test "" do

  end
end
