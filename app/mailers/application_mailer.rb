class ApplicationMailer < ActionMailer::Base
  default from: 'norepry@Koto.jp', charset: 'ISO-2022-JP'
  layout 'mailer'
end
