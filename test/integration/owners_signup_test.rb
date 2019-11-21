require 'test_helper'

class OwnersSignupTest < ActionDispatch::IntegrationTest

  test "誤った登録情報でのログイン" do
    get signup_owner_path
    assert_no_difference 'Owner.count' do
      post owners_path, params: { owner: { name: "",
           email: "aa", password: "aa", password_confirmation: "aa" } }
    end
    assert_template 'owners/new'
  end

  test "正しい登録情報でのログイン" do
    get signup_owner_path
    assert_difference 'Owner.count', 1 do
      post owners_path, params: { owner: { name: "masahiro",
                               email: "abc@gmail.com",
                               password: "1234abcd",
                               password_confirmation: "1234abcd" } }
    end
    follow_redirect!
    assert_template 'owners/show'
    assert_not flash.empty?
  end
end
