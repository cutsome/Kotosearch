require 'test_helper'

class AgentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get agents_path
    assert_response :success
  end

  test "should get new" do
    get new_agent_path
    assert_response :success
  end
end