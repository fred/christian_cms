class Notifications < ActionMailer::Base

  def new_message(message)
    subject         'There is a new message at comunidad-catolica.com'
    recipients      Settings.notifications_email
    from            Settings.site_email
    sent_on         Time.now
    content_type    "text/html"
    body            :message => message
  end

end
