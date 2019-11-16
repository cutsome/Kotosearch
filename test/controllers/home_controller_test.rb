require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "トップページにアクセス可能か" do
    get root_path
    assert_response :success
  end

  test "ご利用ガイドにアクセス可能か" do
    get help_path
    assert_response :success
  end
end
