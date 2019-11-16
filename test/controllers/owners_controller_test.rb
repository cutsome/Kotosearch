require 'test_helper'

class OwnersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get owners_path
    assert_response :success
  end

  test "should get new" do
    get new_owner_path
    assert_response :success
  end
end
