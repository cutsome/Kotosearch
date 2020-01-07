class ApplicationMailer < ActionMailer::Base
  default from: 'norepry@kotosearch.com', charset: 'ISO-2022-JP'
  layout 'mailer'
end
