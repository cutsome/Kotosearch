require 'test_helper'

class AgentTest < ActiveSupport::TestCase

  def setup
    @agent = Agent.new(name: "masahiro", email: "b@gmail.com",
             password: "password", password_confirmation: "password")
  end

  test "有効ユーザー検証" do
    assert @agent.valid?
  end

  test "名前ブランク検証" do
    @agent.name = ""
    assert_not @agent.valid?
  end

  test "名前文字数50字以下制限検証" do
    @agent.name = "a" * 51
    assert_not @agent.valid?
  end

  test "メールブランク検証" do
    @agent.email = ""
    assert_not @agent.valid?
  end

  test "メール文字数255字以下制限検証" do
    @agent.email = "a" * 246 + "@gmail.com"
    assert_not @agent.valid?
  end

  test "メール有効フォーマット検証" do
    valid_addresses = %w[aaaa@foo.com AAAAA@foo.COM A_aaaa@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @agent.email = valid_address
      assert @agent.valid?
    end
  end

  test "メール無効フォーマット検証" do
    invalid_addresses = %w[aaaa@foo,com AAAAA_foo.COM A_aaaa@foo.bar.
                         last@foo_jfirst.jp baz@alice+bob.cn, aaaa@foo..com]
    invalid_addresses.each do |invalid_address|
      @agent.email = invalid_address
      assert_not @agent.valid?
    end
  end

  test "一意性検証" do
    duplicate_user = @agent.dup
    @agent.save
    assert_not duplicate_user.valid?
  end

  test "パスワードブランク検証" do
    @agent.password = @agent.password_confirmation = "" * 8
    assert_not @agent.valid?
  end

  test "パスワード最小8文字検証" do
    @agent.password = @agent.password_confirmation = "a" * 7
    assert_not @agent.valid?
  end

  test "パスワード最大32文字検証" do
    @agent.password = @agent.password_confirmation = "a" * 33
    assert_not @agent.valid?
  end

  test "パスワード半角英数8文字以上検証" do
    @agent.password = @agent.password_confirmation = %w[Abcdef1 aｂcd1234 12345678
                                                     abcdefgh ABCD1234 ABCDefgh あい123456]
    assert_not @agent.valid?
  end
end
