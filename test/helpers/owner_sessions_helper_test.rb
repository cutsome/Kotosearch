require 'test_helper'

class OwnerSessionsHelperTest < ActionView::TestCase

  def setup
    @owner = owners(:owner1)
    owner_remember(@owner)
  end

  test "current_ownerは、sessionがnilでもrightを返す" do
    assert_equal @owner, current_owner
    assert owner_is_logged_in?
  end

  test "current_ownerは、記憶ダイジェストが異なる値の時nilを返す" do
    @owner.update_attribute(:remember_digest, Owner.digest(Owner.new_token))
    assert_nil current_owner
  end
end
