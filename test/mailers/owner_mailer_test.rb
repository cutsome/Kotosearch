require 'test_helper'

class OwnerMailerTest < ActionMailer::TestCase

  test "アカウント有効化" do
    owner = owners(:owner1)
    owner.activation_token = Owner.new_token
    mail = OwnerMailer.account_activation(owner)
    #assert_equal "アカウント有効化", mail.subject
    assert_equal [owner.email], mail.to
    assert_equal ["norepry@Koto.jp"], mail.from
    assert_match owner.name, mail.body.encoded
    assert_match owner.activation_token, mail.body.encoded
    assert_match CGI.escape(owner.email), mail.body.encoded
  end

  test "パスワード再設定" do
    owner = owners(:owner1)
    owner.reset_token = Owner.new_token
    mail = OwnerMailer.password_reset(owner)
    #assert_equal "パスワード再設定", mail.subject
    assert_equal [owner.email], mail.to
    assert_equal ["norepry@Koto.jp"], mail.from
    assert_match owner.reset_token, mail.body.encoded
    assert_match CGI.escape(owner.email), mail.body.encoded
  end
end
