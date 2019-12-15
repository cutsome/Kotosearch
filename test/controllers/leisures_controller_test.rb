require 'test_helper'

class LeisuresControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get leisures_show_url
    assert_response :success
  end

end
