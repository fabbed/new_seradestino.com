class UserObserver < ActiveRecord::Observer
  def after_create(user)
    user.reload
    puts "Observer after create"
    UserMailer.deliver_registered(user)
  end

  # def after_save(user)
  #   user.reload
  #   puts "Observer after save"          
  #   UserMailer.deliver_activated(user) if user.recently_activated?
  # 
  # end
end
