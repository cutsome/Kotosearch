class OwnerMailer < ApplicationMailer

  def account_activation(owner)
    @owner = owner
    mail to: owner.email, subject: "アカウント有効化"
  end

  def password_reset(owner)
    @owner = owner
    mail to: owner.email, subject: "パスワード再設定"
  end
end
