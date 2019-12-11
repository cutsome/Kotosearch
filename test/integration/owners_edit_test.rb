require 'test_helper'

class OwnersEditTest < ActionDispatch::IntegrationTest

  def setup
    @owner = owners(:owner1)
  end

  test "誤った編集情報" do
    owner_login(@owner)
    get edit_owner_path(@owner)
    assert_template 'owners/edit'
    patch owner_path(@owner), params: { owner: { name: "",
                   email: "", password: "", password_confirmation: "" } }
    assert_template 'owners/edit'
  end

  test "正しい編集情報" do
    get edit_owner_path(@owner)
    owner_login(@owner)
    assert_redirected_to edit_owner_url(@owner)
    name = "masahiro nishikawa"
    email = "abcd@gmail.com"
    patch owner_path(@owner), params: { owner: { name: name, email: email } }
    assert_not flash.empty?
    assert_redirected_to @owner
    @owner.reload
    assert_equal name, @owner.name
    assert_equal email, @owner.email
  end
end
