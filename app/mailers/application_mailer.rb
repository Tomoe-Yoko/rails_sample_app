#
class ApplicationMailer < ActionMailer::Base
  default from: "user@realdomain.com"
  layout 'mailer' #app/views/layouts/mailer.html.erb
end
