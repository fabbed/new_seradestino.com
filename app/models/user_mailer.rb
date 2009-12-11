class UserMailer < ActionMailer::Base
  def registered(user)
    setup_email(user)
    @subject    += t("mails.registered_subject")
  
    @body[:url]  = @base_url + "activate/#{user.activation_code}"
  
  end
  
  def activated(user)
    setup_email(user)
    @subject    += t("mails.activated_subject")
    @body[:url]  = @base_url
  end

  def new_comment(story)
    if story.user.present? and story.notifications
      @recipients = story.user.email
    elsif
      @recipients = story.email      
    end
    
    puts "sending mail to: " + @recipients 
    
    @subject = t("mails.new_comment_subject")

    @body[:story]  = story
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
