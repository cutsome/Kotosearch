require 'test_helper'

class OwnersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "誤った登録情報でのサインアップ" do
    get owner_signup_path
    assert_no_difference 'Owner.count' do
      post owners_path, params: { owner: { name: "",
           email: "aa", password: "aa", password_confirmation: "aa" } }
    end
    assert_template 'owners/new'
  end

  test "正しい登録情報でのサインアップ & アカウント有効化" do
    get owner_signup_path
    assert_difference 'Owner.count', 1 do
      post owners_path, params: { owner: { name: "masahiro",
                       email: "abc@gmail.com", password: "1234abcd",
                       password_confirmation: "1234abcd" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    owner = assigns(:owner)
    assert_not owner.activated?
    owner_login(owner)
    get edit_account_activation_path("invalid token", email: owner.email)
    assert_not is_logged_in?
    get edit_account_activation_path(owner.activation_token, email: 'wrong')
    assert_not is_logged_in?
    get edit_account_activation_path(owner.activation_token, email: owner.email)
    assert owner.reload.activated?
    follow_redirect!
    assert_template 'owners/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
