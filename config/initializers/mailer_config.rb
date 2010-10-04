# -*- encoding : utf-8 -*-
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = {
  :address        => "127.0.0.1",
  :port           => 25,
  :domain         => "www.comunidad-catolica.com"
}
