require 'test_helper'

class OwnersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = owners(:owner1)
    @non_admin = owners(:owner2)
  end

  test "ページネーションテスト及び管理者権限による削除テスト" do
    owner_login(@admin)
    get owners_path
    assert_template 'owners/index'
    assert_select 'ul.pagination'
    assert_difference 'Owner.count', -1 do
      delete owner_path(@non_admin)
    end
  end

  test "非管理者のindex" do
    owner_login(@non_admin)
    get owners_path
    assert_select 'a', text: '削除', count: 0
  end
end
