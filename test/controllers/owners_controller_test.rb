require 'test_helper'

class OwnersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @owner = owners(:owner1)
    @other_owner = owners(:owner2)
  end

  test "未ログイン状態でのeditアクセス" do
    get edit_owner_path(@owner)
    assert_not flash.empty?
    assert_redirected_to owner_login_url
  end

  test "未ログイン状態でのupdateアクセス" do
    patch owner_path(@owner), params: { owner: { name: @owner.name,
                                        email: @owner.email } }
    assert_not flash.empty?
    assert_redirected_to owner_login_url
  end

  test "ログイン済の他ユーザーからのeditアクセス" do
    owner_login(@other_owner)
    get edit_owner_path(@owner)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "ログイン済の他ユーザーからのupdateアクセス" do
    owner_login(@other_owner)
    patch owner_path(@owner), params: { owner: { name: @owner.name,
                                        email: @owner.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "Web経由で管理者権限が変更されないか" do
    owner_login(@other_owner)
    assert_not @other_owner.admin?
    patch owner_path(@owner), params: { owner: {
                             password: @other_owner.password,
                             password_confirmation: @other_owner.password,
                             admin: true } }
    assert_not @other_owner.reload.admin?
  end

  test "未ログイン状態でのdeleteアクセスはログイン画面にリダイレクト" do
    assert_no_difference 'Owner.count' do
      delete owner_path(@owner)
    end
    assert_redirected_to owner_login_url
  end

  test "ログイン済の他ユーザーからのdeleteアクセスはルートにリダイレクト" do
    owner_login(@other_owner)
    assert_no_difference 'Owner.count' do
      delete owner_path(@owner)
    end
    assert_redirected_to root_url
  end
end
