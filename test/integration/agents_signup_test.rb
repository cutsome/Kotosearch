require 'test_helper'

class AgentsSignupTest < ActionDispatch::IntegrationTest

  test "誤った登録情報でのサインアップ" do
    get agent_signup_path
    assert_no_difference 'Agent.count' do
      post agents_path, params: { agent: { name: "",
           email: "aa", password: "aa", password_confirmation: "aa" } }
    end
    assert_template 'agents/new'
  end

  test "正しい登録情報でのサインアップ" do
    get agent_signup_path
    assert_difference 'Agent.count', 1 do
      post agents_path, params: { agent: { name: "masahiro",
                       email: "abc@gmail.com", password: "1234abcd",
                       password_confirmation: "1234abcd" } }
    end
    follow_redirect!
    assert_template 'agents/show'
    assert_not flash.empty?
    assert agent_is_logged_in?
  end
end
