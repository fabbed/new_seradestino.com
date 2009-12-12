class Account::AvatarsController < Account::BaseController
  before_filter :find_user
  
  def show
  end
  
  def update

    if @user.update_attributes(params[:user])
      flash[:info] = I18n.t('account.avatar_updated')
      redirect_to my_account_path
    else
      render :action => "show"
    end
    
  end



end
