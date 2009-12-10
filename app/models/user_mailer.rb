class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = @base_url + "activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = @base_url
  end
  
  protected
    def setup_email(user)
      @base_url  = "http://www.seradestino.local/" if RAILS_ENV == "development"
      @base_url  = "http://www.seradestino.com/" if RAILS_ENV == "production"

      @recipients  = "#{user.email}"
      @from        = "conoceos.com <admin@conoceos.com>"
      @subject     = ""
      @reply_to     = "admin@conoceos.com"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
