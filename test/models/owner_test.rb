require 'test_helper'

class OwnerTest < ActiveSupport::TestCase

  def setup
    @owner = Owner.new(name: "masahiro", email: "a@gmail.com",
             password: "password", password_confirmation: "password")
  end

  test "有効ユーザー検証" do
    assert @owner.valid?
  end

  test "名前ブランク検証" do
    @owner.name = ""
    assert_not @owner.valid?
  end

  test "名前文字数50字以下制限検証" do
    @owner.name = "a" * 51
    assert_not @owner.valid?
  end

  test "メールブランク検証" do
    @owner.email = ""
    assert_not @owner.valid?
  end

  test "メール文字数255字以下制限検証" do
    @owner.email = "a" * 246 + "@gmail.com"
    assert_not @owner.valid?
  end

  test "メール有効フォーマット検証" do
    valid_addresses = %w[aaaa@foo.com AAAAA@foo.COM A_aaaa@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @owner.email = valid_address
      assert @owner.valid?
    end
  end

  test "メール無効フォーマット検証" do
    invalid_addresses = %w[aaaa@foo,com AAAAA_foo.COM A_aaaa@foo.bar.
                         last@foo_jfirst.jp baz@alice+bob.cn, aaaa@foo..com]
    invalid_addresses.each do |invalid_address|
      @owner.email = invalid_address
      assert_not @owner.valid?
    end
  end

  test "一意性検証" do
    duplicate_user = @owner.dup
    @owner.save
    assert_not duplicate_user.valid?
  end

  test "パスワードブランク検証" do
    @owner.password = @owner.password_confirmation = "" * 8
    assert_not @owner.valid?
  end

  test "パスワード最小8文字検証" do
    @owner.password = @owner.password_confirmation = "a" * 7
    assert_not @owner.valid?
  end

  test "パスワード最大32文字検証" do
    @owner.password = @owner.password_confirmation = "a" * 33
    assert_not @owner.valid?
  end

  test "パスワード半角英数8文字以上検証" do
    @owner.password = @owner.password_confirmation = %w[Abcdef1 aｂcd1234 12345678
                                                     abcdefgh ABCD1234 ABCDefgh あい123456]
    assert_not @owner.valid?
  end
end
