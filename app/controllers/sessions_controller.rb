# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:email], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      # redirect_back_or_default('/')
      redirect_to my_account_path
      flash[:info] = I18n.t('flash.logged_in_with_success')

    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:info] = I18n.t('flash.logged_out_with_success')
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = I18n.t('flash.login_as_x_not_possible', :email => params[:email])
    logger.warn "Failed login for '#{params[:email]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
