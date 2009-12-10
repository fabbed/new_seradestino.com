class UsersController < LocatableController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
 
  def show
    @user = User.find(params[:id])
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.vcode = cookies[:vcode] if cookies[:vcode]
    success = @user && @user.save
    if success && @user.errors.empty?
      self.current_user = @user
      #redirect_back_or_default('/')
      flash[:info] = I18n.t('flash.thanks_for_signing_up', :email => @user.email, :login => @user.login)
      redirect_to my_account_path
    else
      flash[:error]  = I18n.t('flash.error_in_signing_up')
      render :action => 'new'
    end
  end

  def activate
    @user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && @user && !@user.active?
      @user.activate!
      locate_user
      @user.save
      @user.assign_content
      self.current_user = @user
      flash[:info] = I18n.t('flash.user_activation_complete')
      redirect_to my_account_path
    when params[:activation_code].blank?
      flash[:error] = I18n.t('flash.activation_code_missing_in_signup')
      redirect_back_or_default('/')
    else 
      flash[:error]  = I18n.t('flash.not_existing_activation_code')
      
      redirect_back_or_default('/')
    end
  end
end
