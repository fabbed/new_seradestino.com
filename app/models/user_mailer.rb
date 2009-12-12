class UserMailer < ActionMailer::Base


  def registered(user)
    setup_email(user)
    @subject    += I18n.t("mails.registered_subject")
  
    @body[:url]  = @base_url + "activate/#{user.activation_code}"
  
  end
  
  def activated(user)
    setup_email(user)
    @subject    += I18n.t("mails.activated_subject")
    @body[:url]  = @base_url
  end

  def new_comment(story)
    setup_email_no_user()
        
    if story.user.present? and story.notifications
      @recipients = story.user.email
    elsif story.email.length > 1
      @recipients = story.email      
    end
    
    puts "sending mail to: " + @recipients 
    
    @subject = I18n.t("mails.new_comment_subject")

    @body[:story]  = story
  end

  
  protected
    def setup_email_no_user()
      @base_url  = "http://www.seradestino.local/" if RAILS_ENV == "development"
      @base_url  = "http://www.seradestino.com/" if RAILS_ENV == "production"

      @from        = "seradestino.com <admin@seradestino.com>"
      @subject     = ""
      @reply_to     = "admin@seradestino.com"
      @sent_on     = Time.now
    end

    def setup_email(user)
      @base_url  = "http://www.seradestino.local/" if RAILS_ENV == "development"
      @base_url  = "http://www.seradestino.com/" if RAILS_ENV == "production"

      @recipients  = "#{user.email}"
      @from        = "seradestino.com <admin@seradestino.com>"
      @subject     = ""
      @reply_to     = "admin@seradestino.com"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
