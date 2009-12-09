class Account::AvatarsController < Account::BaseController
  before_filter :find_user
  
  def show
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:info] = I18n.t('txt.users.msg_update_profile_success')
      redirect_to account_path
    else
      render :action => "show"
    end
  end



end
