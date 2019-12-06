require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @agent = agents(:agent1)
    @owner = owners(:owner1)
    @object = @agent || @owner
  end

  test "パスワードリセット統合テスト" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # 無効なメールアドレス
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # 有効なメールアドレス
    post password_resets_path, params: { password_reset: { email: @object.email } }
    assert_not_equal @object.reset_digest, @object.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # パスワード再設定フォームのテスト
    object = assigns(:object)
    # 無効なメールアドレス
    get edit_password_reset_path(object.reset_token, email: "")
    assert_redirected_to root_url
    # 無効なユーザー
    object.toggle!(:activated)
    get edit_password_reset_path(object.reset_token, email: object.email)
    assert_redirected_to root_url
    object.toggle!(:activated)
    # メールアドレスが有効で、トークンが無効
    get edit_password_reset_path("invalid token", email: object.email)
    assert_redirected_to root_url
    # メールアドレスもトークンも有効
    get edit_password_reset_path(object.reset_token, email: object.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", object.email
    # 無効なパスワードとパスワード確認
    patch password_reset_path(object.reset_token), params: { email: object.email,
              object: { password: "1234abcd", password_confirmation: "abcd1234" } }
    assert_select 'ul.alert'
    # パスワードが空
    patch password_reset_path(object.reset_token), params: { email: object.email,
              object: { password: "", password_confirmation: "" } }
    assert_select 'ul.alert'
    # 有効なパスワードとパスワード確認
    patch password_reset_path(object.reset_token), params: { email: object.email,
              object: { password: "1234abcd", password_confirmation: "1234abcd" } }

    #assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to object
  end
end
