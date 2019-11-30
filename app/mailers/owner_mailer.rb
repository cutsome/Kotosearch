class OwnerMailer < ApplicationMailer

  def account_activation(owner)
    @owner = owner
    mail to: owner.email, subject: "アカウント有効化"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
