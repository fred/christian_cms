ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = {
  :address        => "127.0.0.1",
  :port           => 25,
  :domain         => "www.comunidad-catolica.com"
}
ActionMailer::Base.sendmail_settings = {
  :location       => '/usr/sbin/sendmail',
  :arguments      => '-i -t -f info@comunidad-catolica.com'
}