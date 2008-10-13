ActionMailer::DeliveryMethod = :sendmail
ActionMailer::SmtpSettings = {
  :address        => "127.0.0.1",
  :port           => 25,
  :domain         => "www.comunidad-catolica.com"
}

ActionMailer::Base.sendmail_settings = {
  :location       => '/usr/sbin/sendmail',
  :arguments      => '-i -t -f admin@comunidad-catolica.com'
}