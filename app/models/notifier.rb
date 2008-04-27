class Notifier < ActionMailer::Base
  
  def initial_password_email(user)
    @user = user
    @from = ("admin@comunidad-catolica.com")
    @recipients = @user.email
    @sent_on = Time.now
    @subject = 'El Nuevo Sitio de la Comunidad Catolica, Su login y password.'
    @content_type = "text/html" # Important, must be html
    @body["user"] = @user
  end
  
  def mass_email(user,msg_time,msg_subject,msg_body)
    @user = user
    @from = ("admin@comunidad-catolica.com")
    @recipients = @user.email
    @sent_on = msg_time
    @subject = msg_subject
    @content_type = "text/html" # Important, must be html
    @body["user"] = @user
    @body["body"] = msg_body
  end
  
end
