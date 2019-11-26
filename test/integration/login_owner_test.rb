require 'test_helper'

class LoginOwnerTest < ActionDispatch::IntegrationTest

  def setup
    @owner = owners(:owner1)
  end

  test "誤った情報でのログイン" do
    get login_owner_path
    assert_template 'owner_sessions/new'
    post login_owner_path, params: { session: { email: "", password: "" } }
    assert_template 'owner_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "正しい情報でのログイン" do
    get login_owner_path
    post login_owner_path, params: { session: { email: @owner.email,
                                          password: '1234abcd' } }
    assert owner_is_logged_in?
    assert_redirected_to @owner
    follow_redirect!
    assert_template 'owners/show'
    assert_select "a[href=?]", login_owner_path, count: 0
    assert_select "a[href=?]", logout_owner_path
    assert_select "a[href=?]", owner_path(@owner)
    delete logout_owner_path
    assert_not owner_is_logged_in?
    assert_redirected_to root_url
    delete logout_owner_path
    follow_redirect!
    assert_select "a[href=?]", login_owner_path
    assert_select "a[href=?]", logout_owner_path, count: 0
    assert_select "a[href=?]", owner_path(@owner), count: 0
  end

  test "remember_meオン" do
    owner_login(@owner, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "remember_meオフ" do
    owner_login(@owner, remember_me: '1')
    delete logout_owner_path
    owner_login(@owner, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
